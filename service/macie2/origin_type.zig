/// Specifies how Amazon Macie found the sensitive data that produced a finding.
/// Possible values are:
pub const OriginType = enum {
    sensitive_data_discovery_job,
    automated_sensitive_data_discovery,

    pub const json_field_names = .{
        .sensitive_data_discovery_job = "SENSITIVE_DATA_DISCOVERY_JOB",
        .automated_sensitive_data_discovery = "AUTOMATED_SENSITIVE_DATA_DISCOVERY",
    };
};
