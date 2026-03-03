const CustomizableMetricHeadroom = @import("customizable_metric_headroom.zig").CustomizableMetricHeadroom;
const CustomizableMetricThreshold = @import("customizable_metric_threshold.zig").CustomizableMetricThreshold;

/// Defines the various metric parameters that can be customized, such as
/// threshold and headroom.
pub const CustomizableMetricParameters = struct {
    /// The headroom value in percentage used for the specified metric parameter.
    ///
    /// The following lists the valid values for CPU and memory utilization.
    ///
    /// * CPU utilization: `PERCENT_30 | PERCENT_20 | PERCENT_0`
    ///
    /// * Memory utilization: `PERCENT_30 | PERCENT_20 | PERCENT_10`
    headroom: ?CustomizableMetricHeadroom = null,

    /// The threshold value used for the specified metric parameter.
    ///
    /// You can only specify the threshold value for CPU utilization.
    threshold: ?CustomizableMetricThreshold = null,

    pub const json_field_names = .{
        .headroom = "headroom",
        .threshold = "threshold",
    };
};
