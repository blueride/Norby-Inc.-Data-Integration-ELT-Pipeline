import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.pool import QueuePool
import boto3
from config2 import get_config2
import os

# Function to extract data from a database table
def extract_data_from_database(database_url, schema, table_name):
    engine = create_engine(database_url, poolclass=QueuePool)
    query = f"SELECT * FROM {schema}.{table_name}"
    
    try:
        # Using a database connection pool for better performance
        with engine.connect() as conn:
            df = pd.read_sql(query, conn)
        return df
    except Exception as e:
        # Handling exception
        print(f"Error extracting data from the database: {str(e)}")
        return None

# Function to load data into an Amazon S3 bucket
def load_data_to_s3(dataframe, file_name, bucket_name, key):
    s3 = boto3.client('s3')
    try:
        # Convert the DataFrame directly to a CSV file
        dataframe.to_csv(file_name, index=False)

        # Upload the CSV file to the specified S3 bucket and folder
        with open(file_name, 'rb') as csv_file: 
            s3.put_object(Bucket=bucket_name, Key=key, Body=csv_file) 
            print(f"Successfully uploaded {file_name} to s3//{bucket_name}/{folder_name}/{group_id}")
    except Exception as e:
        print(f"Error loading data to S3: {str(e)}")
    finally:
        return None


if __name__ == "__main__":
    # Get configuration settings from the config2 module
    config2= get_config2()
    
    # Iterate through tables in the configuration and extract/load data
    for table_name, table_config in config2["tables"].items():
        schema = config2["schema"]
        database_url = config2["database_url"]
        bucket_name = config2["bucket_name"]
        group_id = config2["group_id"]
        folder_name = config2["folder_name"]
        file_name = table_config["file_name"] 
        key = f"{folder_name}/{group_id}/{file_name}"  
        
        # Extract data from the database
        dataframe = extract_data_from_database(database_url, schema, table_name)
        
        # Load data to Amazon S3
        load_data_to_s3(dataframe, file_name, bucket_name, key)
