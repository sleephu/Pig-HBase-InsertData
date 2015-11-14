REGISTER '/Users/sleephu2/Desktop/HBaseLib/hbase-common-1.1.2.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/hbase-client-1.1.2.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/hbase-server-1.1.2.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/hbase-protocol-1.1.2.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/htrace-core-3.1.0-incubating.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/zookeeper-3.4.6.jar’;
REGISTER '/Users/sleephu2/Desktop/HBaseLib/guava-12.0.1.jar’;

dailyDS = LOAD '/NYSE/NYSE_daily_prices*.csv' USING  org.apache.pig.piggybank.storage.CSVLoader() AS (exchange:chararray,stock_symbol:chararray,date:chararray,stock_price_open:chararray,stock_price_high:chararray,stock_price_low:chararray,stock_price_close:chararray,stock_volume:chararray,stock_price_adj_close:chararray);
dailyDS = ORDER dailyDS BY date; 
groupSymbol = GROUP dailyDS by stock_symbol;
ds = FOREACH groupSymbol GENERATE group as stock_symbol,dailyDS.date,dailyDS.stock_price_open,dailyDS.stock_price_high,dailyDS.stock_price_low,dailyDS.stock_price_close,dailyDS.stock_volume,dailyDS.stock_price_adj_close,dailyDS.exchange;
copy = STORE ds INTO 'hbase://StockInfo' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('info:stock_symbol info:date info:stock_price_open info:stock_price_high info:stock_price_low info:stock_price_close info:stock_volume info:stock_price_adj_close info:exchange’);

—divs dataset
divs = LOAD '/NYSE/NYSE_dividends*.csv' USING  org.apache.pig.piggybank.storage.CSVLoader() AS (exchange:chararray,stock_symbol:chararray,date:chararray,dividends:chararray);
divsGroup = GROUP divs by stock_symbol;
db = FOREACH divsGroup GENERATE group as stock_symbol, divs.date, divs.dividends, divs.exchange;
cp = STORE db INTO 'hbase://StockDivs' USING org.apache.pig.backend.hadoop.hbase.HBaseStorage('info:stock_symbol info:date info:dividends info:exchange’);
