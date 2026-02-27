pub const AnomalyDetectorType = enum {
    single_metric,
    metric_math,

    pub const json_field_names = .{
        .single_metric = "SINGLE_METRIC",
        .metric_math = "METRIC_MATH",
    };
};
