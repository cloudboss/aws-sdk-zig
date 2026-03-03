const Matcher = @import("matcher.zig").Matcher;
const TargetGroupProtocol = @import("target_group_protocol.zig").TargetGroupProtocol;
const HealthCheckProtocolVersion = @import("health_check_protocol_version.zig").HealthCheckProtocolVersion;

/// Describes the health check configuration of a target group. Health check
/// configurations aren't used for target groups of type `LAMBDA` or `ALB`.
pub const HealthCheckConfig = struct {
    /// Indicates whether health checking is enabled.
    enabled: ?bool = null,

    /// The approximate amount of time, in seconds, between health checks of an
    /// individual target. The range is 5–300 seconds. The default is 30 seconds.
    health_check_interval_seconds: ?i32 = null,

    /// The amount of time, in seconds, to wait before reporting a target as
    /// unhealthy. The range is 1–120 seconds. The default is 5 seconds.
    health_check_timeout_seconds: ?i32 = null,

    /// The number of consecutive successful health checks required before
    /// considering an unhealthy target healthy. The range is 2–10. The default is
    /// 5.
    healthy_threshold_count: ?i32 = null,

    /// The codes to use when checking for a successful response from a target.
    matcher: ?Matcher = null,

    /// The destination for health checks on the targets. If the protocol version is
    /// `HTTP/1.1` or `HTTP/2`, specify a valid URI (for example, `/path?query`).
    /// The default path is `/`. Health checks are not supported if the protocol
    /// version is `gRPC`, however, you can choose `HTTP/1.1` or `HTTP/2` and
    /// specify a valid URI.
    path: ?[]const u8 = null,

    /// The port used when performing health checks on targets. The default setting
    /// is the port that a target receives traffic on.
    port: ?i32 = null,

    /// The protocol used when performing health checks on targets. The possible
    /// protocols are `HTTP` and `HTTPS`. The default is `HTTP`.
    protocol: ?TargetGroupProtocol = null,

    /// The protocol version used when performing health checks on targets. The
    /// possible protocol versions are `HTTP1` and `HTTP2`.
    protocol_version: ?HealthCheckProtocolVersion = null,

    /// The number of consecutive failed health checks required before considering a
    /// target unhealthy. The range is 2–10. The default is 2.
    unhealthy_threshold_count: ?i32 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .health_check_interval_seconds = "healthCheckIntervalSeconds",
        .health_check_timeout_seconds = "healthCheckTimeoutSeconds",
        .healthy_threshold_count = "healthyThresholdCount",
        .matcher = "matcher",
        .path = "path",
        .port = "port",
        .protocol = "protocol",
        .protocol_version = "protocolVersion",
        .unhealthy_threshold_count = "unhealthyThresholdCount",
    };
};
