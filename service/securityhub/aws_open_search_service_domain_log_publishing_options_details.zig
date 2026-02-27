const AwsOpenSearchServiceDomainLogPublishingOption = @import("aws_open_search_service_domain_log_publishing_option.zig").AwsOpenSearchServiceDomainLogPublishingOption;

/// Configures the CloudWatch Logs to publish for the OpenSearch domain.
pub const AwsOpenSearchServiceDomainLogPublishingOptionsDetails = struct {
    /// Configures the OpenSearch audit logs publishing.
    audit_logs: ?AwsOpenSearchServiceDomainLogPublishingOption,

    /// Configures the OpenSearch index logs publishing.
    index_slow_logs: ?AwsOpenSearchServiceDomainLogPublishingOption,

    /// Configures the OpenSearch search slow log publishing.
    search_slow_logs: ?AwsOpenSearchServiceDomainLogPublishingOption,

    pub const json_field_names = .{
        .audit_logs = "AuditLogs",
        .index_slow_logs = "IndexSlowLogs",
        .search_slow_logs = "SearchSlowLogs",
    };
};
