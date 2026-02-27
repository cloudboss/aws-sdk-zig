/// Specifies the Amazon CloudWatch Logs configuration for the Express service
/// container.
pub const ExpressGatewayServiceAwsLogsConfiguration = struct {
    /// The name of the CloudWatch Logs log group to send container logs to.
    log_group: []const u8,

    /// The prefix for the CloudWatch Logs log stream names. The default for an
    /// Express service is `ecs`.
    log_stream_prefix: []const u8,

    pub const json_field_names = .{
        .log_group = "logGroup",
        .log_stream_prefix = "logStreamPrefix",
    };
};
