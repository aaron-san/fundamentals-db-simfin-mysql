Most DIY investors doing serious analysis eventually hit the same wall: Yahoo Finance is fine for a quick chart, but it falls apart the moment you want to query fundamentals and prices together, backtest a ratio, or screen thousands of tickers at once.

So I built an alternative: a MySQL database that joins fundamentals, company profiles, and daily/monthly share prices into one queryable structure.

A few key features:

1. A dates table was created that maps fundamentals report and publish dates to the next trading day's market close price, lettting us quickly structure a model or backtest without look-ahead bias.

2. A filtered prices table with extreme price values (close or adjusted close prices over $100,000) removed was created to facilitate lower-budget investors.

3. Profitability, liquidity, solvency, efficiency, and valuation ratios were computed directly in SQL, not bolted on in a spreadsheet after the fact.

The result: one database you can query for screening, backtesting, or ratio analysis, without wrestling an API or reconciling three data exports by hand.
Full build (SQL + Python in a Jupyter Notebook): https://aaron-san.github.io/indicators/
Just the notebook: https://github.com/aaron-san/fundamentals-db-simfin-mysql/blob/main/index.ipynb
If you're a MySQL-comfortable investor tired of Yahoo Finance's limits, give it a try and share how you will use it.