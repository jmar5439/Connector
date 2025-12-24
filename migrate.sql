CREATE TABLE edc_asset (
    asset_id VARCHAR PRIMARY KEY,
    created_at BIGINT NOT NULL,
    properties JSONB NOT NULL
);

CREATE TABLE edc_data_address (
    asset_id VARCHAR PRIMARY KEY,
    properties JSONB NOT NULL,
    FOREIGN KEY (asset_id) REFERENCES edc_asset(asset_id) ON DELETE CASCADE
);


CREATE TABLE edc_policy_definition (
    policy_id VARCHAR PRIMARY KEY,
    created_at BIGINT NOT NULL,
    policy JSONB NOT NULL
);


CREATE TABLE edc_contract_definition (
    contract_definition_id VARCHAR PRIMARY KEY,
    created_at BIGINT NOT NULL,
    access_policy_id VARCHAR NOT NULL,
    contract_policy_id VARCHAR NOT NULL,
    assets_selector JSONB NOT NULL
);


CREATE TABLE edc_transfer_process (
    transfer_process_id VARCHAR PRIMARY KEY,
    type VARCHAR NOT NULL,
    state INTEGER NOT NULL,
    state_count INTEGER NOT NULL,
    created_at BIGINT NOT NULL,
    updated_at BIGINT NOT NULL,
    error_detail TEXT,
    resource_manifest JSONB,
    provisioned_resource_set JSONB,
    content_data_address JSONB,
    callback_addresses JSONB,
    private_properties JSONB,
    correlation_id VARCHAR,
    lease_id VARCHAR
);

CREATE INDEX idx_transfer_process_state ON edc_transfer_process(state);
CREATE INDEX idx_transfer_process_lease ON edc_transfer_process(lease_id);


CREATE TABLE edc_data_plane_transfer (
    transfer_id VARCHAR PRIMARY KEY,
    process_id VARCHAR NOT NULL,
    state INTEGER NOT NULL,
    created_at BIGINT NOT NULL,
    updated_at BIGINT NOT NULL,
    source_data_address JSONB NOT NULL,
    destination_data_address JSONB NOT NULL,
    error_detail TEXT,
    lease_id VARCHAR
);

CREATE INDEX idx_dpt_state ON edc_data_plane_transfer(state);
CREATE INDEX idx_dpt_lease ON edc_data_plane_transfer(lease_id);



CREATE TABLE edc_data_plane_instance (
    instance_id VARCHAR PRIMARY KEY,
    url VARCHAR NOT NULL,
    allowed_source_types JSONB,
    allowed_destination_types JSONB,
    properties JSONB,
    last_active BIGINT
);


CREATE TABLE edc_edr (
    transfer_process_id VARCHAR PRIMARY KEY,
    agreement_id VARCHAR NOT NULL,
    created_at BIGINT NOT NULL,
    expires_at BIGINT,
    data_address JSONB NOT NULL
);


CREATE TABLE edc_lease (
    lease_id VARCHAR PRIMARY KEY,
    leased_by VARCHAR NOT NULL,
    leased_at BIGINT NOT NULL,
    expires_at BIGINT
);
