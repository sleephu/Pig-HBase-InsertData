##### Pig-HBase-InsertData
###### * Notice: It is mapreduce mode
##### Usage:

1. How to import multiple files using Pig?
  1. In this sample, under NYSE folder, there're two types of files in terms of file name and file schema:
    1. NYSE_daily_prices_A.csv, NYSE_daily_prices_B.csv, NYSE_daily_prices_C.csv... 
      * Use wildcard matching: NYSE_daily_prices*.csv
    2. NYSE_dividends_A.csv, NYSE_dividends_B.csv, NYSE_dividends_B.csv...
      * Use wildcard matching: NYSE_dividends*.csv
2. Using CSV Loader
      * USING  org.apache.pig.piggybank.storage.CSVLoader()
  

