/// A specification for a predefined metric.
pub const PredefinedMetricSpecification = struct {
    /// The metric type. You can only apply SageMaker metric types to SageMaker
    /// endpoints.
    predefined_metric_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .predefined_metric_type = "PredefinedMetricType",
    };
};
