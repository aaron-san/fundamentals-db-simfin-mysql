
use fundamentals_data;

-- create index idx_us_shareprices_daily on us_shareprices_daily (Ticker, Date);

-- with PriceStats as (
-- select 
-- 	Ticker,
--     Date,
--     Close,
--     max(Close) over (partition by Ticker order by Date) as RunningMax,
--     (Close - max(Close) over (partition by Ticker order by Date))/max(Close) over (partition by Ticker order by Date) as Drawdown
--     from us_shareprices_daily
-- ),
with BsRatios as (
select distinct
	bs.Ticker,
	`Report Date` as Date,
	`Total Current Assets` / `Total Current Liabilities` as CurrentRatio,
    `Cash, Cash Equivalents & Short Term Investments` / `Total Current Liabilities` as AcidRatio,
    (COALESCE(`Short Term Debt`,0) + COALESCE(`Long Term Debt`,0)) / `Total Assets` as DebtRatio
    from us_balance_ttm bs
left join us_companies co
on bs.SimFinId = co.SimFinId

), 
prices_joined as (
	select 
		p1.Ticker,
        p1.Date,
        p1.`Close`,
        p2.Date as DateThreeMonthsForward,
        p2.`Close` as CloseThreeMonthsForward
   from us_shareprices_daily p1
   LEFT JOIN us_shareprices_daily p2
   on p1.Ticker = p2.Ticker 
   -- and p2.Date = date_add(p1.Date, interval 3 month) -- get exact date 3 months later
   -- filter where p2.Date is 
   and p2.Date = (
	select min(Date)
    from us_shareprices_daily
    where Ticker = p1.Ticker
    and Date >= date_add(p1.Date, interval 3 month)
    )
),

ratios as (
select 
    br.Ticker,
    br.Date, 
    CurrentRatio,
    AcidRatio,
    DebtRatio,
    `Adj. Close` as AdjClose
from BsRatios br
left join us_shareprices_daily p
on br.Ticker = p.Ticker and br.Date = p.Date
)
 
 -- select * FROM ratios
 select * from BsRatios
 limit 10


-- select 
-- 	count(*) as ratios_rows,
-- 	(select count(*) from unique_rows) as unique_rows
-- from ratios






-- SELECT *
-- FROM (
--     SELECT 
--         *,
--         ROW_NUMBER() OVER (
--             PARTITION BY Ticker
--             ORDER BY Date
--         ) AS rn
--     FROM ratios
-- ) t
-- WHERE rn <= 2;

