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
# Import from incoming to pending 
starlake load
```

