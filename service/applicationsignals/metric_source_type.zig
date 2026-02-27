pub const MetricSourceType = enum {
    service_operation,
    cloudwatch_metric,
    service_dependency,

    pub const json_field_names = .{
        .service_operation = "SERVICE_OPERATION",
        .cloudwatch_metric = "CLOUDWATCH_METRIC",
        .service_dependency = "SERVICE_DEPENDENCY",
    };
};
