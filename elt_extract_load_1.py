import boto3
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.pool import QueuePool
from config import get_config

# Function to download a file from S3
def download_file_from_s3(bucket_name, file_key, local_file_name):
    s3 = boto3.client('s3')
    try:
        s3.download_file(bucket_name, file_key, local_file_name)
        print(f"Downloaded {local_file_name}")
        # creating pandas dataframe for downloaded data
        df = pd.read_csv(local_file_name)
        return df
    except Exception as e:
        print(f"Failed to download {local_file_name}: {str(e)}")

# Function to preprocess orders data
def preprocess_orders_data(data):
    data['order_date'] = pd.to_datetime(data['order_date'])
    return data

# Function to preprocess shipment_deliveries data
def preprocess_shipments_deliveries_data(data):
    data['shipment_date'] = pd.to_datetime(data['shipment_date'])
    data['delivery_date'] = pd.to_datetime(data['delivery_date'])
    return data


def load_data_to_warehouse(data, table_name, database_url, schema, preprocess_function):
    # create database engine connection pool to better manage iterative connections
    engine = create_engine(database_url, poolclass=QueuePool)
    try:
        # Preprocess the data if a preprocess function is provided
        if preprocess_function == "preprocess_orders_data":
            data = preprocess_orders_data(data)
        if preprocess_function == "preprocess_shipments_deliveries_data":
            data = preprocess_shipments_deliveries_data(data)
        # Loading the DataFrame into the database
        with engine.connect() as conn:
            data.to_sql(name=table_name, con=engine, schema=schema, if_exists="append", index=False)
            print(f"Data successfully loaded into {schema}.{table_name}")
    except Exception as e:
        print(f'Error loading {table_name} table: {str(e)}')
    finally:
        return None
    
if __name__ == "__main__":
    # Get configuration settings from the config module
    config= get_config()

    # Iterate through tables in the configuration and extract/load data
    for table_name, table_config in config["tables"].items():
        schema = config["schema"]
        database_url = config["database_url"]
        bucket_name = config["bucket_name"]
        folder_name = config["folder_name"]
        local_file_name = table_config["local_file_name"]
        file_name = table_config['file_name'] 
        file_key = f"{folder_name}/{file_name}"
        preprocess_function = table_config["preprocess_function"]
        
        # extract data from data lake
        data = download_file_from_s3(bucket_name, file_key, local_file_name)

        # load data to warehouse
        load_data_to_warehouse(data, table_name, database_url, schema, preprocess_function)


