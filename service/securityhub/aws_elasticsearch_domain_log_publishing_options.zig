const AwsElasticsearchDomainLogPublishingOptionsLogConfig = @import("aws_elasticsearch_domain_log_publishing_options_log_config.zig").AwsElasticsearchDomainLogPublishingOptionsLogConfig;

/// configures the CloudWatch Logs to publish for the
/// Elasticsearch domain.
pub const AwsElasticsearchDomainLogPublishingOptions = struct {
    audit_logs: ?AwsElasticsearchDomainLogPublishingOptionsLogConfig,

    /// Configures the OpenSearch index logs
    /// publishing.
    index_slow_logs: ?AwsElasticsearchDomainLogPublishingOptionsLogConfig,

    /// Configures the OpenSearch search slow log
    /// publishing.
    search_slow_logs: ?AwsElasticsearchDomainLogPublishingOptionsLogConfig,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
        .index_slow_logs = "IndexSlowLogs",
        .search_slow_logs = "SearchSlowLogs",
    };
};
