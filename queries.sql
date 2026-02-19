-- 1. Top 10 Symbols by Open Interest Change Across Exchanges
SELECT
    exchange_name,
    symbol,
    SUM(chg_in_oi) AS total_oi_change
FROM fo_data
GROUP BY exchange_name, symbol
ORDER BY total_oi_change DESC
LIMIT 10;


-- 2. 7-Day Rolling Volatility for NIFTY Options
SELECT
    symbol,
    timestamp,
    close,
    STDDEV(close) OVER (
        PARTITION BY symbol
        ORDER BY timestamp
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS rolling_7day_volatility
FROM fo_data
WHERE symbol = 'NIFTY'
AND option_typ IN ('CE', 'PE')
ORDER BY timestamp;


-- 3. Cross-Exchange Comparison (MCX Gold vs NSE Index Futures)
SELECT
    exchange_name,
    instrument,
    AVG(settle_pr) AS avg_settle_price
FROM fo_data
WHERE
    (exchange_name = 'MCX' AND symbol LIKE '%GOLD%')
    OR
    (exchange_name = 'NSE' AND instrument = 'FUTIDX')
GROUP BY exchange_name, instrument;


-- 4. Option Chain Summary (Grouped by Expiry and Strike)
SELECT
    symbol,
    expiry_dt,
    strike_pr,
    option_typ,
    SUM(contracts) AS total_volume,
    SUM(open_int) AS total_open_interest
FROM fo_data
WHERE option_typ IN ('CE', 'PE')
GROUP BY symbol, expiry_dt, strike_pr, option_typ
ORDER BY symbol, expiry_dt, strike_pr;


-- 5. Max Volume in Last 30 Days (Performance Optimized)
SELECT
    symbol,
    MAX(contracts) AS max_volume_last_30_days
FROM fo_data
WHERE timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY symbol;


-- 6. EXPLAIN ANALYZE for Performance Verification
EXPLAIN ANALYZE
SELECT
    symbol,
    MAX(contracts)
FROM fo_data
WHERE timestamp >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY symbol;


-- 7. Open Interest Ranking Across Exchanges
SELECT
    exchange_name,
    symbol,
    SUM(open_int) AS total_open_interest,
    RANK() OVER (
        PARTITION BY exchange_name
        ORDER BY SUM(open_int) DESC
    ) AS oi_rank
FROM fo_data
GROUP BY exchange_name, symbol
ORDER BY exchange_name, oi_rank;
