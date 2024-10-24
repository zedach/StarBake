# Starlake Demo 


##  Step 0 – Bootstrap

```shell 
# Starlake Bootstrap 
starlake bootstrap

```

## Step 1 – Extract

```shell 
# extract
starlake extract-data --config metadata/extract/my_extract_config.sl.yml --outputDir datasets/incoming/starbake     
```

```shell 
# show audit table 
duckdb datasets/duckdb.db 
 ```

```shell 
# SQL audit extraction
select * from audit.SL_LAST_EXPORT order by end_ts desc;
```

## Step 2 – Load

```shell 
# Create a virtual environment (optional) 
python3 -m pip install virtualenv && python3 -m venv .venv
```

```shell 
# Activate the virtual environment (optional) 
source .venv/bin/activate
```

```shell 
# Generate dummy files 
python3 -m pip install -r _scripts/requirements.txt && python3 _scripts/dummy_data_generator.py
```

```shell 
# infer schema from sample files 
starlake infer-schema --domain starbake --table Customers --input datasets/incoming/starbake/day_1/customers_extract_0001.csv
```

```shell 
# infer schema from sample files 
starlake infer-schema --domain starbake --table Orders --input datasets/incoming/starbake/day_1/orders_extract_0001.json
```

```shell 
# infer schema from sample files 
starlake infer-schema --domain starbake --table Products --input datasets/incoming/starbake/day_1/products_extract_0001.json
```

```shell 
# infer schema from sample files 
starlake infer-schema --domain starbake --table Ingredients --input datasets/incoming/starbake/day_1/ingredients_extract_0001.tsv 
```

```shell 
# Edit inferred Yaml
git checkout 1d6a75c9f -- ./metadata/load/starbake/
```

```shell 
# Import from incoming to pending 
starlake import
```

```shell 
# load to default env 
starlake load
```

```shell 
# Configure gcloud connection 
gcloud auth application-default login 
gcloud config set project starlake-demo
```


```shell 
# load to Bigquery  https://console.cloud.google.com/bigquery?project=starlake-demo
SL_ENV=BQ starlake load
```
## Step 3 – Transform

```shell 
# Write transform sql query
git checkout 8892e67a -- ./metadata/transform
git checkout d3ffbaef -- ./metadata/env.BQ.sl.yml
git checkout d3ffbaef -- ./metadata/env.sl.yml
```

```shell 
# Create datasets if not
bq mk --location=europe-west1 --dataset starlake-demo:Customers
bq mk --location=europe-west1 --dataset starlake-demo:Products
```

```shell 
# Export BQ env
export SL_ENV="BQ"
echo $SL_ENV
```

```shell 
# Run the transformations in order ⬇️ 
starlake transform --name Customers.CustomerLifetimeValue
```
```shell 
starlake transform --name Customers.HighValueCustomers
```
```shell 
starlake transform --name Products.ProductProfitability
```
```shell 
starlake transform --name Products.MostProfitableProducts
```
```shell 
starlake transform --name Products.ProductPerformance
```
```shell 
starlake transform --name Products.TopSellingProducts
```
```shell 
starlake transform --name Products.TopSellingProfitableProducts
```

```shell 
# Run the transformations recursively 🌀
starlake transform --name Customers.HighValueCustomers --recursive 
```

```shell 
# Run the transformations recursively 🌀
starlake transform --name Products.TopSellingProfitableProducts --recursive
```

## Step 4 – Orchestration 

### RUN with Dagster
```shell 
# Install the dagster webserver 
python3 -m pip install dagster-webserver
```

```shell 
# Install the starlake dagster libraries for shell 
python3 -m pip install 'starlake-dagster[shell]'
```

```shell 
# Generate DAGs 
starlake dag-generate --clean
```

```shell 
# Load the DAGs with dagster 
DAGSTER_HOME=${PWD} dagster dev \
    -f metadata/dags/generated/load/dagster_all_load.py \
    -f metadata/dags/generated/transform/dagster_all_tasks.py 
```

```shell 
# Import from incoming to pending 
starlake import
```
