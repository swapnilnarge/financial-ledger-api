CREATE TABLE accounts (
                          id BIGSERIAL PRIMARY KEY,
                          code VARCHAR(50) UNIQUE,
                          type VARCHAR(20) NOT NULL CHECK (type IN ('CUSTOMER', 'SYSTEM')),
                          status VARCHAR(20) NOT NULL CHECK (status IN ('ACTIVE', 'FROZEN', 'CLOSED')),
                          balance NUMERIC(19, 4) NOT NULL DEFAULT 0.0000,
                          version BIGINT NOT NULL DEFAULT 0,
                          created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

                          CONSTRAINT chk_customer_balance CHECK (type <> 'CUSTOMER' or balance >= 0),
                          CONSTRAINT chk_account_code_rule CHECK (
                              (type = 'CUSTOMER' and code IS NULL) or
                              (type = 'SYSTEM' and code IS NOT NULL)
                              )
);

CREATE INDEX idx_accounts_code ON accounts(code);
CREATE INDEX idx_accounts_type ON accounts(type);