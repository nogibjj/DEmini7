
[![CI](https://github.com/nogibjj/DEmini7/actions/workflows/cicd.yml/badge.svg)](https://github.com/nogibjj/DEmini7/actions/workflows/cicd.yml)

## IDS706_Week7

## Purpose of project
The goal of this project is to create an ETL-Query pipeline utilizing a cloud service like Databricks. This pipeline will involve tasks such as extracting data from Kaggle public datasets, cleaning and transforming the data, then loading it into Databricks SQL Warehouse. Once the data is in place, we'll be able to run complex queries that may involve tasks like joining tables, aggregating data, and sorting results. This will be accomplished by establishing a database connection to Databricks. 
## Preparation
1. open codespaces 
2. wait for container to be built and virtual environment to be activated with requirements.txt installed 
3. make your own .env file to store your Databricks' secrets as it requires a conncection to be established to Databricks
4. extract: run `make extract`
5. transform and load: run `make transform_load`
6. query: run `make query` or  `etl_query general_query "<insert query>"`
<img width="800" alt="image" src="https://github.com/user-attachments/assets/2429681e-2984-4a61-b0a8-aaca97a9081b">


## Complex Query
Explanations of query above like'<insert query>':
```sql
    SELECT t1.country, t1.category, t1.category,
                AVG(t1.Followers) as avg_followers,
                COUNT(*) as total_Account
            FROM default.InstagramData t1
            JOIN default.InstagramTop1000 t2 ON t1.Account = t2.Account
            GROUP BY t1.country, t1.category
            ORDER BY avg_followers DESC
            LIMIT 10
```
- SELECT Clause:

- t1.country: Retrieves the country from the InstagramData table. t1.category, t1.category: Appears to have a duplicate column. This might be a typo, as you likely meant to select only one t1.category.
AVG(t1.Followers) AS avg_followers: Calculates the average number of followers for each group of country and category. COUNT(*) AS total_Account: Counts the total number of accounts in each group.

- Groups the data by country and category to calculate aggregate values (like AVG and COUNT).
- Sorts the results in descending order by the average number of followers.
- Limits the output to the top 10 results with the highest average followers.
   <img width="1170" alt="image" src="https://github.com/user-attachments/assets/3507be22-338f-4585-8e93-0c8baf56a80b">



## Check format and test errors 
1. Format code `make format`
2. Lint code `make lint`
3. Test coce `make test`
<img width="793" alt="image" src="https://github.com/user-attachments/assets/d31ded63-a84f-4138-a298-d23bb0ded9ac">


### File Structure
```
DEmini6/
├── .devcontainer/
│   ├── devcontainer.json
│   └── Dockerfile
├── .github/
├── .gitignore
├── data/
│   ├── instagram_Data.csv
│   └── instagram_global_top_1000.csv
├── Dockerfile
├── LICENSE
├── main.py
├── Makefile
├── mylib/
│   ├── __init__.py
│   ├── __pycache__/
│   ├── extract.py
│   ├── query.py
│   └── transform_load.py
├── query_log.md
├── README.md
├── requirements.txt
├── setup.sh
├── setup.py
└── test_main.py
```
## References 
1. https://github.com/databricks/databricks-sql-python
2. https://github.com/nogibjj/cloud-database-LAB
3. https://learn.microsoft.com/en-us/azure/databricks/sql/admin/create-sql-warehouse
