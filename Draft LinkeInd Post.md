
Most DIY investors doing serious analysis eventually hit the same wall: Yahoo Finance is fine for a quick chart, but can become useless the moment you want to query fundamentals and prices together, backtest a ratio, or screen thousands of tickers at once.

So I built an alternative - a MySQL database that joins fundamentals, company profiles, and daily/monthly share prices into one queryable structure. 

A few decisions mattered critically in the ratio constructions:

1. Price dates are matched to the day after each fundamentals report is published — not before — to avoid look-ahead bias in any backtest.

2. Extreme price errors (some tickers showed Close and Adjusted Prices over $100,000). These were filtered out before performing ratio calculations.

3. Profitability, liquidity, solvency, efficiency, and valuation ratios are computed directly in SQL — not bolted on in a spreadsheet after the fact.

The result: one database you can query for screening, backtesting, or ratio analysis, without wrestling an API or reconciling three data exports by hand.

Full build (with the SQL and Python in a Jupyter Notebook) is here: https://aaron-san.github.io/indicators/, or just the Jupyter Notebook ([here](https://github.com/aaron-san/fundamentals-db-simfin-mysql/blob/main/index.ipynb))

If you're a MySQL-comfortable investor tired of Yahoo Finance's limits, please try it out.