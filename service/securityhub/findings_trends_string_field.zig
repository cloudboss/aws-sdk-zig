pub const FindingsTrendsStringField = enum {
    account_id,
    region,
    finding_type,
    finding_status,
    cve_id,
    compliance_status,
    compliance_control,
    finding_class,
    provider_name,
    finding_activity_name,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .region = "REGION",
        .finding_type = "FINDING_TYPE",
        .finding_status = "FINDING_STATUS",
        .cve_id = "CVE_ID",
        .compliance_status = "COMPLIANCE_STATUS",
        .compliance_control = "COMPLIANCE_CONTROL",
        .finding_class = "FINDING_CLASS",
        .provider_name = "PROVIDER_NAME",
        .finding_activity_name = "FINDING_ACTIVITY_NAME",
    };
};
