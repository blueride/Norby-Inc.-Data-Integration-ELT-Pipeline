# Norby Inc. Data Integration ELT Pipeline

Welcome to the Norby Inc. Data Integration ELT Pipeline project! This repository contains Python scripts that extract data from a cloud source, loads the data into a data warehouse, then extract transformed data from the data warehouse back to the cloud source. It also contains SQL scripts that perform data transformation and analysis. In this README, we'll provide an overview of the project, its functionality, and how to use it.

## Table of Contents

- [Introduction](#introduction)
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Components](#components)
- [Use Cases](#use-cases)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Data Analysis Insights](#data-analysis-insights)
- [Value Proposition](#value-proposition)
- [Contributing](#contributing)
- [License](#license)


## Introduction: 

The Norby Inc. Data Integration Pipeline is a robust data integration solution designed to seamlessly extract, load, and transform data between Amazon S3 and a PostgreSQL database. 

This powerful tool streamlines the process of managing data stored in the cloud and relational databases, providing Norby Inc. with the agility to make data-driven decisions efficiently.

The pipeline comprises a set of Python scripts and SQL transformation scripts that work harmoniously to handle data operations with ease. It empowers Norby Inc. to efficiently manage their data, ensuring it is always available, well-organized, and ready for analysis.

## Project Overview

In today's data-driven world, organizations like Norby Inc. face the challenge of efficiently handling and extracting insights from large and diverse datasets. The Norby Inc. Data Integration Pipeline simplifies this process by providing a comprehensive set of tools and workflows:

• Data Extraction: Retrieve data from Amazon S3   buckets and PostgreSQL databases effortlessly.

• Data Loading: Store and organize data within a PostgreSQL database, ensuring data consistency and reliability.

• Data Transformation: Apply SQL transformation scripts to process data and derive meaningful insights for reporting and analytics.

This project offers a cohesive and efficient solution for Norby Inc. to manage their data, from extraction to transformation, enabling them to extract maximum value from their data assets.

## Key Features

The Norby Inc. Data Integration Pipeline offers the following key features:

• Effortless Data Extraction: Quickly and securely extract data from Amazon S3 buckets and PostgreSQL databases, simplifying the data acquisition process.

• Seamless Data Loading: Load data from various sources into a PostgreSQL database, ensuring data consistency and reliability.

• Flexible Data Transformation: Utilize SQL transformation scripts to process data and generate valuable insights for reporting and analytics.

• Scalability: The pipeline can scale to handle large datasets, making it suitable for growing data needs.

• Maintainability: The project follows best practices for code organization and uses SQLAlchemy for database interactions, making it easy to maintain and extend.

Reliability: Exception handling, data validation, and logging ensure data quality and pipeline reliability.

## Components

The Norby Inc. Data Integration Pipeline consists of the following components:

1. Python Scripts:

	• extract_load_s3_to_postgres.py: Extracts data from an S3 bucket and loads it into a PostgreSQL database.
	
	• extract_load_postgres_to_s3.py: Extracts data from PostgreSQL and saves it to an S3 bucket.
	
	• execute_sql_script_files.py: Executes SQL script files for data transformation.
	


2. SQL Transformation Scripts:

	• agg_public_holiday.sql: Example SQL transformation script for aggregating total orders made on public holidays for each month of the given year interval.
	
	• agg_shipments.sql: Example SQL transformation script for aggregating total number of late shipments and total number of undelivered items.
	
    • agg_best_performing_product.sql: Example SQL transformation script for finding the best-performing products.

## Use Cases

The Norby Inc. Data Integration Pipeline is versatile and can be applied to various use cases, including but not limited to:

• Sales Analytics: Analyzing sales data to identify trends and opportunities.

• Inventory Management: Managing and optimizing inventory levels.

• Customer Insights: Gaining insights into customer behavior and preferences.

• Operational Efficiency: Monitoring and improving operational processes.

• Financial Analysis: Analyzing financial data for better financial planning.

The pipeline can be customized to suit Norby Inc.'s specific data integration and analysis needs.

## Dependencies

### Python Dependencies

The ELT Pipeline relies on the following Python libraries:

• boto3: AWS SDK for Python. Used for interacting with S3.

• pandas: Data manipulation library for handling data in Python DataFrames.

• sqlalchemy: SQL toolkit and Object-Relational Mapping (ORM) library.

• config: Custom module for configuration settings to run extract_load_s3_to_postgres.py.

• config2: Custom module for configuration settings to run extract_load_postgres_to_s3.py.

• config_tr: Custom module for configuration settings to run execute_sql_script_files.py.

The config scripts are replaced with templates as: config_template, config2_template, config_tr_template, respectively.


### SQL Dependencies

The SQL transformation scripts rely on the following dependencies:

• PostgreSQL Database: The target database where data will be loaded and transformed.

• Additional SQL functions and data tables (e.g., c5gp015210_staging.orders, if_common.dim_products) as required by the transformations.

## Getting Started

### Installation

1. Clone the repository to your local machine:

bash
```
git clone https://github.com/Owengerald/norby_inc_analytics_elt_pipeline.git
```

2. Navigate to the project directory:

bash
```
cd your-repo
```

3. Install the required Python packages:

bash
```
pip install -r requirements.txt
```


### Configuration

Configure the pipeline by modifying the configuration files (config.py, config2.py, config_tr.py) to match your environment and data sources.




## Usage

### Extracting and Loading from S3 to PostgreSQL

To extract data from an S3 bucket and load it into a PostgreSQL database, use extract_load_s3_to_postgres.py. Modify the configuration in config.py and execute the script.

bash
```
python extract_load_s3_to_postgres.py
```

### Extracting from PostgreSQL to S3

To extract data from a PostgreSQL database and save it to an S3 bucket, use extract_postgres_to_s3.py. Modify the configuration in config2.py and execute the script.

bash
```
python extract_load_postgres_to_s3.py
```

### Running SQL Transformations

To execute SQL transformation scripts, use execute_sql_script_files.py. Ensure that your PostgreSQL database is properly configured and the SQL scripts are in the specified directory. Modify the configuration in config_tr.py and execute the script.

bash
```
python execute_sql_script_files.py
```
## Folder Structure

The project follows a structured folder layout for easy navigation:

plaintext
```
├── data/

├── python_scripts/

│   ├── extract_load_s3_to_postgres.py

│   ├── extract_postgres_to_s3.py

│   ├── execute_sql_script_files.py

│   ├── config.py

│   ├── config2.py

│   ├── config_tr.py

├── sql_scripts/

│   ├── agg_public_holiday.sql

│   ├── agg_shipments.sql

│   ├── agg_best_performing_product.sql

├── config_templates

│   ├── config_template.py

│   ├── config2_template.py

│   ├── config_tr_template.py

├── .gitignore

├── README.md

└── requirements.txt
```

## Data Analysis Insights

### Analysis Performed by SQL Scripts

1. agg_public_holiday.sql

• Purpose: This SQL script creates and populates the agg_public_holiday table in the analytics schema.

• Analysis: This script calculates the total number of orders placed on public holidays for each month of the year. It considers working days (Monday to Friday) and identifies public holidays between a specific date range ('2021-09-05' to '2022-09-05'). The results are aggregated and stored in the agg_public_holiday table, providing valuable insights into order patterns on public holidays.

2. agg_shipments.sql

• Purpose: This SQL script creates and populates the agg_shipments table in the analytics schema.

• Analysis: The agg_shipments script performs two main analyses:

	• It calculates the total number of late shipments. Late shipments are defined as those where the delivery date is null and the shipment date is at least 6 days after the order date. This analysis helps identify issues with delivery timeliness.
	
	• It calculates the total number of undelivered items. Undelivered items are orders with no delivery date and no shipment date, where the order date is within 15 days of '2022-09-05'. This analysis can help in understanding and addressing issues related to undelivered items.
	
	• The results of these analyses are stored in the agg_shipments table.
	
3. best_performing_product.sql

• Purpose: This SQL script creates and populates the best_performing_product table in the analytics schema.

• Analysis: The best_performing_product script focuses on analyzing product performance. It calculates various metrics, including:

	• The most ordered day for each product.
	
	• Whether a product was ordered on public holidays.
	
	• The total review points received by each product.
	
	• The percentage of one-star, two-star, three-star, four-star, and five-star reviews for each product.
	
	• The percentage of early and late shipments for each product.
	
	• The script ranks products based on their total review points and selects the best-performing product with the highest review points.
	
These SQL scripts provide valuable insights into order patterns, shipment performance, and product performance, which can be used for data-driven decision-making and optimizing various aspects of your business operations within the analytics schema.

## Value Proposition

### Scalability

The Norby Inc. Data Integration Pipeline is designed to handle both small and large datasets. Its scalability ensures that it can grow with Norby Inc.'s data needs, accommodating increasing data volumes without compromising performance.

### Maintainability

The project is organized following best practices, making it easy to maintain and extend. The use of SQLAlchemy for database interactions provides a reliable and maintainable foundation for database operations.

### Reliability

Exception handling, data validation, and logging mechanisms are in place to ensure the pipeline's reliability. Data quality and consistency are paramount, helping Norby Inc. make informed decisions based on trustworthy data.

## Contributing

If you wish to contribute to this project, please follow the standard GitHub flow:

1. Fork the project.

2. Create a new branch for your feature or bug fix.

3. Make your changes and submit a pull request.

4. Follow the project's coding style and conventions.

## License

Personal Project Disclaimer

This project is a personal endeavor and is not provided with any licensing or permission for external use. It is intended solely for personal, non-commercial purposes. No warranties or guarantees are provided, and the project creator assumes no liability for any issues or consequences arising from its use or misuse.

You may view, study, and learn from this project, but you may not copy, distribute, modify, or use it for any purpose other than personal exploration. If you wish to use or adapt any part of this project for any other purpose, please seek explicit permission from the project creator.

© Clement Addo - 2023
