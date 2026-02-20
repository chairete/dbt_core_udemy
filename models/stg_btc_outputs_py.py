import pandas
import simplejson

def model(dbt, session):
  dbt.config(
    materialized="table",
    packages=["pandas", "simplejson"]
  )

  df = dbt.ref("stg_btc").to_pandas()

  # convert string to dictonary
  df["OUTPUTS"] = df["OUTPUTS"].apply(simplejson.loads)

  ## workaround for not beeing able to print things
  #raise Exception(type(df))

  ##get the list elements from outputs and create a row for each element of it
  df_exploded = df.explode("OUTPUTS").reset_index(drop=True)

  #normalize into a flat table from OUTPUTS and select only address and value
  df_outputs = pandas.json_normalize(df_exploded["OUTPUTS"])[["address", "value"]]

  #concat data previously exloded minus the OUTPUTS
  df_final = pandas.concat([df_exploded.drop(columns="OUTPUTS"), df_outputs], axis=1)

  df_final = df_final[df_final["address"].notnull()]

  #uppercase columns => else it could be a problem for the downstream models 
  #e.g. needing to referencing them with quots ("addes" instead of address)
  df_final.columns= [col.upper() for col in df_final.columns]



  return df_final
