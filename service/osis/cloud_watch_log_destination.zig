/// The destination for OpenSearch Ingestion logs sent to Amazon CloudWatch.
pub const CloudWatchLogDestination = struct {
    /// The name of the CloudWatch Logs group to send pipeline logs to. You can
    /// specify an existing
    /// log group or create a new one. For example,
    /// `/aws/vendedlogs/OpenSearchService/pipelines`.
    log_group: []const u8,

    pub const json_field_names = .{
        .log_group = "LogGroup",
    };
};
