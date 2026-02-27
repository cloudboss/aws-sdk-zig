/// An array of key-value pairs to set for advanced control over Amazon Redshift
/// Serverless.
pub const ConfigParameter = struct {
    /// The key of the parameter. The options are `auto_mv`, `datestyle`,
    /// `enable_case_sensitive_identifier`, `enable_user_activity_logging`,
    /// `query_group`, `search_path`, `require_ssl`, `use_fips_ssl`, and either
    /// `wlm_json_configuration` or query monitoring metrics that let you define
    /// performance boundaries. You can either specify individual query monitoring
    /// metrics (such as `max_scan_row_count`, `max_query_execution_time`) or use
    /// `wlm_json_configuration` to define query queues with rules, but not both.
    /// For more information about query monitoring rules and available metrics, see
    /// [Query monitoring metrics for Amazon Redshift
    /// Serverless](https://docs.aws.amazon.com/redshift/latest/dg/cm-c-wlm-query-monitoring-rules.html#cm-c-wlm-query-monitoring-metrics-serverless).
    parameter_key: ?[]const u8,

    /// The value of the parameter to set.
    parameter_value: ?[]const u8,

    pub const json_field_names = .{
        .parameter_key = "parameterKey",
        .parameter_value = "parameterValue",
    };
};
