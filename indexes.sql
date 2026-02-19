-- INDEXES FOR PERFORMANCE OPTIMIZATION


-- 1. Index on symbol (frequent filtering & grouping)
CREATE INDEX idx_symbol
ON fo_data(symbol);


-- 2. Index on timestamp (time-series queries)
CREATE INDEX idx_timestamp
ON fo_data(timestamp);


-- 3. Index on exchange_name (cross-exchange comparison)
CREATE INDEX idx_exchange_name
ON fo_data(exchange_name);


-- 4. Composite Index (symbol + timestamp)
-- Optimizes queries filtering by symbol and date range
CREATE INDEX idx_symbol_timestamp
ON fo_data(symbol, timestamp);


-- 5. BRIN Index on timestamp (for large datasets 10M+ rows)
-- Efficient for large time-ordered data
CREATE INDEX idx_timestamp_brin
ON fo_data
USING BRIN(timestamp);


-- 6. Index on expiry date (option chain queries)
CREATE INDEX idx_expiry_dt
ON fo_data(expiry_dt);


-- 7. Index on strike price (option chain filtering)
CREATE INDEX idx_strike_pr
ON fo_data(strike_pr);
