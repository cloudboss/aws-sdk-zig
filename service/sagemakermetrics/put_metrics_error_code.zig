pub const PutMetricsErrorCode = enum {
    metric_limit_exceeded,
    internal_error,
    validation_error,
    conflict_error,

    pub const json_field_names = .{
        .metric_limit_exceeded = "METRIC_LIMIT_EXCEEDED",
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .conflict_error = "CONFLICT_ERROR",
    };
};
