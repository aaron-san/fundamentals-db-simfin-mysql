 use fundamentals_data;
 
-- --------------
-- MONTHLY PRICES
-- --------------

drop table if exists us_shareprices_monthly;
-- When you drop the table, all indexes disappear automatically, so you must recreate them.

CREATE TABLE us_shareprices_monthly AS
SELECT
    Ticker,
    MAX(Date) AS Date,
    -- GROUP_CONCAT() → builds a list of Close prices
	-- ORDER BY Date DESC → newest price first
	-- SUBSTRING_INDEX(..., ',', 1) → pick the first price
    SUBSTRING_INDEX(
        GROUP_CONCAT(Close ORDER BY Date DESC),
        ',',
        1
    ) AS Close,
    SUBSTRING_INDEX(
        GROUP_CONCAT(`Adj. Close` ORDER BY Date DESC),
        ',',
        1
    ) AS AdjClose
FROM us_shareprices_daily
GROUP BY
    Ticker,
    YEAR(Date),
    MONTH(Date);
    
    
CREATE INDEX idx_month_end_ticker_date
ON us_shareprices_monthly (Ticker, Date);
