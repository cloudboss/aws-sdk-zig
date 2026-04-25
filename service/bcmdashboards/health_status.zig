const HealthStatusCode = @import("health_status_code.zig").HealthStatusCode;
const StatusReason = @import("status_reason.zig").StatusReason;

/// Contains the health status information for a scheduled report, including the
/// status code and any reasons for an unhealthy state.
pub const HealthStatus = struct {
    /// The timestamp when the health status was last refreshed.
    last_refreshed_at: ?i64 = null,

    /// The health status code. `HEALTHY` indicates the scheduled report is
    /// configured properly and has all required permissions to execute. `UNHEALTHY`
    /// indicates the scheduled report is unable to deliver the notification to the
    /// default Amazon EventBridge EventBus in your account and your action is
    /// needed. The reason for the unhealthy state is captured in the health status
    /// reasons.
    status_code: HealthStatusCode,

    /// The list of reasons for the current health status. Only present when the
    /// status is `UNHEALTHY`.
    status_reasons: ?[]const StatusReason = null,

    pub const json_field_names = .{
        .last_refreshed_at = "lastRefreshedAt",
        .status_code = "statusCode",
        .status_reasons = "statusReasons",
    };
};
