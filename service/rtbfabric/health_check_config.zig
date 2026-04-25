const Protocol = @import("protocol.zig").Protocol;

/// The health check configuration for a managed endpoint. Defines how the
/// service probes instances in the Auto Scaling group to determine their health
/// status.
pub const HealthCheckConfig = struct {
    /// The number of consecutive successful health checks required before an
    /// instance is considered healthy. Valid range is 2 to 10.
    healthy_threshold_count: ?i32 = null,

    /// The interval between health check probes, in seconds. Valid range is 5 to
    /// 60.
    interval_seconds: ?i32 = null,

    /// The destination path for the health check request. Must start with `/`.
    path: []const u8,

    /// The port to use for health check probes. Valid range is 80 to 65535.
    port: i32,

    /// The protocol to use for health check probes.
    protocol: ?Protocol = null,

    /// The expected HTTP status code or status code pattern from healthy instances.
    /// Supports a single code (for example, `200`), a range (for example,
    /// `200-299`), or a comma-separated list (for example, `200,204`).
    status_code_matcher: ?[]const u8 = null,

    /// The timeout for each health check probe, in milliseconds. Valid range is 100
    /// to 5000.
    timeout_ms: ?i32 = null,

    /// The number of consecutive failed health checks required before an instance
    /// is considered unhealthy. Valid range is 2 to 10.
    unhealthy_threshold_count: ?i32 = null,

    pub const json_field_names = .{
        .healthy_threshold_count = "healthyThresholdCount",
        .interval_seconds = "intervalSeconds",
        .path = "path",
        .port = "port",
        .protocol = "protocol",
        .status_code_matcher = "statusCodeMatcher",
        .timeout_ms = "timeoutMs",
        .unhealthy_threshold_count = "unhealthyThresholdCount",
    };
};
