const SummaryMetricConfigurationStatus = @import("summary_metric_configuration_status.zig").SummaryMetricConfigurationStatus;

/// The configuration of summary metrics.
pub const SummaryMetricConfiguration = struct {
    /// The status of the configuration of summary metrics.
    status: ?SummaryMetricConfigurationStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
