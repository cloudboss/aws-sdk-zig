/// The container health check command and associated configuration parameters
/// for the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsHealthCheckDetails = struct {
    /// The command that the container runs to determine whether it is healthy.
    command: ?[]const []const u8,

    /// The time period in seconds between each health check execution. The default
    /// value is 30 seconds.
    interval: ?i32,

    /// The number of times to retry a failed health check before the container is
    /// considered unhealthy. The default value is 3.
    retries: ?i32,

    /// The optional grace period in seconds that allows containers time to
    /// bootstrap before failed health checks count towards the maximum number of
    /// retries.
    start_period: ?i32,

    /// The time period in seconds to wait for a health check to succeed before it
    /// is considered a failure. The default value is 5.
    timeout: ?i32,

    pub const json_field_names = .{
        .command = "Command",
        .interval = "Interval",
        .retries = "Retries",
        .start_period = "StartPeriod",
        .timeout = "Timeout",
    };
};
