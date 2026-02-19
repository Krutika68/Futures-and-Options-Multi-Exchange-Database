-- SCHEMA: Multi-Exchange Derivatives Database


-- Drop table if exists (for safe re-run)
DROP TABLE IF EXISTS fo_data CASCADE;



-- MAIN FACT TABLE

CREATE TABLE fo_data (
    
    id SERIAL PRIMARY KEY,

    instrument VARCHAR(20) NOT NULL,
    symbol VARCHAR(50) NOT NULL,
    expiry_dt DATE NOT NULL,
    strike_pr NUMERIC(12,2),
    option_typ VARCHAR(5),

    open NUMERIC(12,2),
    high NUMERIC(12,2),
    low NUMERIC(12,2),
    close NUMERIC(12,2),
    settle_pr NUMERIC(12,2),

    contracts BIGINT,
    val_inlakh NUMERIC(15,2),
    open_int BIGINT,
    chg_in_oi BIGINT,

    timestamp DATE NOT NULL,

    exchange_name VARCHAR(10) DEFAULT 'NSE',

    -- Basic Data Integrity Constraints
    CHECK (contracts >= 0),
    CHECK (open_int >= 0),
    CHECK (option_typ IN ('CE', 'PE', 'XX') OR option_typ IS NULL)

);
