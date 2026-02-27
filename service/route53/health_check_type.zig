pub const HealthCheckType = enum {
    http,
    https,
    http_str_match,
    https_str_match,
    tcp,
    calculated,
    cloudwatch_metric,
    recovery_control,
};
