const HealthCheckProtocol = @import("health_check_protocol.zig").HealthCheckProtocol;

/// Describes the settings for the health check that App Runner performs to
/// monitor the health of a service.
pub const HealthCheckConfiguration = struct {
    /// The number of consecutive checks that must succeed before App Runner decides
    /// that the service is healthy.
    ///
    /// Default: `1`
    healthy_threshold: ?i32,

    /// The time interval, in seconds, between health checks.
    ///
    /// Default: `5`
    interval: ?i32,

    /// The URL that health check requests are sent to.
    ///
    /// `Path` is only applicable when you set `Protocol` to `HTTP`.
    ///
    /// Default: `"/"`
    path: ?[]const u8,

    /// The IP protocol that App Runner uses to perform health checks for your
    /// service.
    ///
    /// If you set `Protocol` to `HTTP`, App Runner sends health check requests to
    /// the HTTP path specified by `Path`.
    ///
    /// Default: `TCP`
    protocol: ?HealthCheckProtocol,

    /// The time, in seconds, to wait for a health check response before deciding it
    /// failed.
    ///
    /// Default: `2`
    timeout: ?i32,

    /// The number of consecutive checks that must fail before App Runner decides
    /// that the service is unhealthy.
    ///
    /// Default: `5`
    unhealthy_threshold: ?i32,

    pub const json_field_names = .{
        .healthy_threshold = "HealthyThreshold",
        .interval = "Interval",
        .path = "Path",
        .protocol = "Protocol",
        .timeout = "Timeout",
        .unhealthy_threshold = "UnhealthyThreshold",
    };
};
