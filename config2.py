# Configuration settings
config2 = {
    "database_url": "postgresql://c5gp015210:rYm1NiK0qt@34.89.230.185:5432/d2b_accessment",
    "schema": "c5gp015210_analytics",  
    "bucket_name": "10alytics-capstone-bucket",
    "folder_name": "analytics_export",
    "group_id": "grp01",  
    "tables": {
        "agg_public_holiday": {
            "file_name": "agg_public_holiday.csv",
        },
        "agg_shipments": {
            "file_name": "agg_shipments.csv",
        },
        "best_performing_product": {
            "file_name": "best_performing_product.csv",
        },
        
    }
}

# defining function to access config dictionary
def get_config2():
    return config2
