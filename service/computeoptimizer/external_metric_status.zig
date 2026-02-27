const ExternalMetricStatusCode = @import("external_metric_status_code.zig").ExternalMetricStatusCode;

/// Describes Compute Optimizer's integration status with your chosen external
/// metric provider. For example, Datadog.
pub const ExternalMetricStatus = struct {
    /// The status code for Compute Optimizer's integration with an external metrics
    /// provider.
    status_code: ?ExternalMetricStatusCode,

    /// The reason for Compute Optimizer's integration status with your external
    /// metric provider.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
