/// The configuration for reading agent traces from CloudWatch logs as input for
/// online evaluation.
pub const CloudWatchLogsInputConfig = struct {
    /// The list of CloudWatch log group name prefixes to monitor for agent traces.
    /// Specify this instead of `logGroupNames` to match log groups by prefix.
    /// Specify either `logGroupNames` or `logGroupNamePrefixes`, not both. One of
    /// the two is required.
    log_group_name_prefixes: ?[]const []const u8 = null,

    /// The list of CloudWatch log group names to monitor for agent traces.
    log_group_names: []const []const u8 = &.{},

    /// The list of service names to filter traces within the specified log groups.
    /// Used to identify relevant agent sessions.
    service_names: []const []const u8,

    pub const json_field_names = .{
        .log_group_name_prefixes = "logGroupNamePrefixes",
        .log_group_names = "logGroupNames",
        .service_names = "serviceNames",
    };
};
