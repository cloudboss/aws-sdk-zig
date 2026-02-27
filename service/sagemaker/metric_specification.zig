const CustomizedMetricSpecification = @import("customized_metric_specification.zig").CustomizedMetricSpecification;
const PredefinedMetricSpecification = @import("predefined_metric_specification.zig").PredefinedMetricSpecification;

/// An object containing information about a metric.
pub const MetricSpecification = union(enum) {
    /// Information about a customized metric.
    customized: ?CustomizedMetricSpecification,
    /// Information about a predefined metric.
    predefined: ?PredefinedMetricSpecification,

    pub const json_field_names = .{
        .customized = "Customized",
        .predefined = "Predefined",
    };
};
