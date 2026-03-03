const CustomizableMetricName = @import("customizable_metric_name.zig").CustomizableMetricName;
const CustomizableMetricParameters = @import("customizable_metric_parameters.zig").CustomizableMetricParameters;

/// The preference to control the resource’s CPU utilization threshold, CPU
/// utilization headroom, and memory utilization headroom.
///
/// This preference is only available for the Amazon EC2 instance resource type.
pub const UtilizationPreference = struct {
    /// The name of the resource utilization metric name to customize.
    metric_name: ?CustomizableMetricName = null,

    /// The parameters to set when customizing the resource utilization thresholds.
    metric_parameters: ?CustomizableMetricParameters = null,

    pub const json_field_names = .{
        .metric_name = "metricName",
        .metric_parameters = "metricParameters",
    };
};
