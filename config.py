# Configuration settings
config = {
    "bucket_name": "10alytics-capstone-bucket",
    "folder_name": "orders_data",
    "database_url": "postgresql://c5gp015210:rYm1NiK0qt@34.89.230.185:5432/d2b_accessment",
    "schema": "c5gp015210_staging",
    "tables": {
        "orders": {
            "file_name": "orders.csv",
            "local_file_name": "orders_data.csv",
            "preprocess_function": "preprocess_orders_data"
        },     
        "reviews": {
            "file_name": "reviews.csv",
            "local_file_name": "reviews_data.csv",
            "preprocess_function": None  
        },
        "shipments_deliveries": {
            "file_name": "shipments_deliveries.csv",
            "local_file_name": "shipments_deliveries_data.csv",
            "preprocess_function": "preprocess_shipments_deliveries_data" 
        }
    }
}

# function to return config variable
def get_config():
    return config
