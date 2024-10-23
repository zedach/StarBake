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
duckdb sample-data/starbake/duckdb.db 
 ```

```shell 
# SQL audit extraction
select * from audit.SL_LAST_EXPORT order by end_ts desc;
```