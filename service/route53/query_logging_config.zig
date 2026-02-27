/// A complex type that contains information about a configuration for DNS query
/// logging.
pub const QueryLoggingConfig = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch Logs log group that Amazon
    /// Route 53
    /// is publishing logs to.
    cloud_watch_logs_log_group_arn: []const u8,

    /// The ID of the hosted zone that CloudWatch Logs is logging queries for.
    hosted_zone_id: []const u8,

    /// The ID for a configuration for DNS query logging.
    id: []const u8,
};
