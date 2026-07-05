 use fundamentals_data;
 
-- ------------
-- PRICE STATS
-- ------------

DROP TABLE IF EXISTS us_shareprices_stats;

CREATE TABLE us_shareprices_stats (
    Ticker VARCHAR(20),
    Date DATE,
    Close DECIMAL(12,4),
    RunningMax DECIMAL(12,4),
    Drawdown DECIMAL(12,4),
    MA_3M DECIMAL(12,4),
    MA_6M DECIMAL(12,4),
    MA_1Y DECIMAL(12,4)
);


INSERT INTO us_shareprices_stats 
select 
	Ticker,
    Date,
    Close,
    max(AdjClose) over (partition by Ticker order by Date) as RunningMax,
    round((AdjClose - max(AdjClose) over (partition by Ticker order by Date))/ nullif(max(AdjClose) over (partition by Ticker order by Date),0), 3) as Drawdown,
    CASE 
		WHEN COUNT(*) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		) = 3
		THEN round(AVG(AdjClose) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
		), 3)
		ELSE NULL
	END as MA_3M,
    CASE 
		WHEN COUNT(*) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
		) = 6
		THEN round(AVG(AdjClose) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 5 PRECEDING AND CURRENT ROW
		), 3)
		ELSE NULL
	END as MA_6M,
    CASE 
		WHEN COUNT(*) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
		) = 12
		THEN round(AVG(AdjClose) OVER (
			PARTITION BY Ticker
			ORDER BY Date
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW
		), 3)
		ELSE NULL
	END as MA_1Y
    from us_shareprices_monthly
