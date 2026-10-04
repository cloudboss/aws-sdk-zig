const CloudWatchFilterConfig = @import("cloud_watch_filter_config.zig").CloudWatchFilterConfig;

/// The configuration for reading agent traces from CloudWatch Logs.
pub const CloudWatchLogsSource = struct {
    /// Optional filter configuration to narrow down which sessions to evaluate.
    filter_config: ?CloudWatchFilterConfig = null,

    /// The list of CloudWatch log group name prefixes to read agent traces from.
    /// Specify this instead of `logGroupNames` to match log groups by prefix.
    /// Maximum of 5 prefixes. Specify either `logGroupNames` or
    /// `logGroupNamePrefixes`, not both. One of the two is required.
    log_group_name_prefixes: ?[]const []const u8 = null,

    /// The list of CloudWatch log group names to read agent traces from. Maximum of
    /// 10 log groups.
    log_group_names: []const []const u8 = &.{},

    /// The list of agent service names to filter traces within the specified log
    /// groups.
    service_names: []const []const u8,

    pub const json_field_names = .{
        .filter_config = "filterConfig",
        .log_group_name_prefixes = "logGroupNamePrefixes",
        .log_group_names = "logGroupNames",
        .service_names = "serviceNames",
    };
};
