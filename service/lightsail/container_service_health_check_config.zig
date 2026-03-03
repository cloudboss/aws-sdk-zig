/// Describes the health check configuration of an Amazon Lightsail container
/// service.
pub const ContainerServiceHealthCheckConfig = struct {
    /// The number of consecutive health checks successes required before moving the
    /// container to
    /// the `Healthy` state. The default value is `2`.
    healthy_threshold: ?i32 = null,

    /// The approximate interval, in seconds, between health checks of an individual
    /// container.
    /// You can specify between 5 and 300 seconds. The default value is `5`.
    interval_seconds: ?i32 = null,

    /// The path on the container on which to perform the health check. The default
    /// value is
    /// `/`.
    path: ?[]const u8 = null,

    /// The HTTP codes to use when checking for a successful response from a
    /// container. You can
    /// specify values between `200` and `499`. You can specify multiple values
    /// (for example, `200,202`) or a range of values (for example,
    /// `200-299`).
    success_codes: ?[]const u8 = null,

    /// The amount of time, in seconds, during which no response means a failed
    /// health check. You
    /// can specify between 2 and 60 seconds. The default value is `2`.
    timeout_seconds: ?i32 = null,

    /// The number of consecutive health check failures required before moving the
    /// container to
    /// the `Unhealthy` state. The default value is `2`.
    unhealthy_threshold: ?i32 = null,

    pub const json_field_names = .{
        .healthy_threshold = "healthyThreshold",
        .interval_seconds = "intervalSeconds",
        .path = "path",
        .success_codes = "successCodes",
        .timeout_seconds = "timeoutSeconds",
        .unhealthy_threshold = "unhealthyThreshold",
    };
};
