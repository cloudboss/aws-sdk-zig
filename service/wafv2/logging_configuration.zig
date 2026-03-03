const LoggingFilter = @import("logging_filter.zig").LoggingFilter;
const LogScope = @import("log_scope.zig").LogScope;
const LogType = @import("log_type.zig").LogType;
const FieldToMatch = @import("field_to_match.zig").FieldToMatch;

/// Defines an association between logging destinations and a web ACL resource,
/// for logging
/// from WAF. As part of the association, you can specify parts of the standard
/// logging
/// fields to keep out of the logs and you can specify filters so that you log
/// only a subset of
/// the logging records.
///
/// If you configure data protection for the web ACL, the protection applies to
/// the data that WAF sends to the logs.
///
/// You can define one logging destination per web ACL.
///
/// You can access information about the traffic that WAF inspects using the
/// following
/// steps:
///
/// * Create your logging destination. You can use an Amazon CloudWatch Logs log
///   group, an Amazon Simple Storage Service (Amazon S3) bucket, or an Amazon
///   Kinesis Data Firehose.
///
/// The name that you give the destination must start with `aws-waf-logs-`.
/// Depending on the type of destination, you might need to configure additional
/// settings or permissions.
///
/// For configuration requirements and pricing information for each destination
/// type, see
/// [Logging web ACL
/// traffic](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html)
/// in the *WAF Developer Guide*.
///
/// * Associate your logging destination to your web ACL using a
/// `PutLoggingConfiguration` request.
///
/// When you successfully enable logging using a `PutLoggingConfiguration`
/// request, WAF creates an additional role or policy that is required to write
/// logs to the logging destination. For an Amazon CloudWatch Logs log group,
/// WAF creates a resource policy on the log group.
/// For an Amazon S3 bucket, WAF creates a bucket policy. For an Amazon Kinesis
/// Data Firehose, WAF creates a service-linked role.
///
/// For additional information about web ACL logging, see
/// [Logging web ACL traffic
/// information](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html)
/// in the *WAF Developer Guide*.
pub const LoggingConfiguration = struct {
    /// The logging destination configuration that you want to associate with the
    /// web
    /// ACL.
    ///
    /// You can associate one logging destination to a web ACL.
    log_destination_configs: []const []const u8,

    /// Filtering that specifies which web requests are kept in the logs and which
    /// are dropped.
    /// You can filter on the rule action and on the web request labels that were
    /// applied by
    /// matching rules during web ACL evaluation.
    logging_filter: ?LoggingFilter = null,

    /// The owner of the logging configuration, which must be set to `CUSTOMER` for
    /// the configurations that you manage.
    ///
    /// The log scope `SECURITY_LAKE` indicates a configuration that is managed
    /// through Amazon Security Lake. You can use Security Lake to collect log and
    /// event data from various sources for normalization, analysis, and management.
    /// For information, see
    /// [Collecting data from Amazon Web Services
    /// services](https://docs.aws.amazon.com/security-lake/latest/userguide/internal-sources.html)
    /// in the *Amazon Security Lake user guide*.
    ///
    /// The log scope `CLOUDWATCH_TELEMETRY_RULE_MANAGED` indicates a configuration
    /// that is managed through Amazon CloudWatch Logs for telemetry data collection
    /// and analysis. For information, see
    /// [What is Amazon CloudWatch Logs
    /// ?](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/WhatIsCloudWatchLogs.html)
    /// in the *Amazon CloudWatch Logs user guide*.
    ///
    /// Default: `CUSTOMER`
    log_scope: ?LogScope = null,

    /// Used to distinguish between various logging options. Currently, there is one
    /// option.
    ///
    /// Default: `WAF_LOGS`
    log_type: ?LogType = null,

    /// Indicates whether the logging configuration was created by Firewall Manager,
    /// as part of an
    /// WAF policy configuration. If true, only Firewall Manager can modify or
    /// delete the
    /// configuration.
    ///
    /// The logging configuration can be created by Firewall Manager for use with
    /// any web ACL that Firewall Manager is using for an WAF policy.
    /// Web ACLs that Firewall Manager creates and uses have their
    /// `ManagedByFirewallManager` property set to true. Web ACLs that were created
    /// by a customer account and then retrofitted by Firewall Manager for use by a
    /// policy have their `RetrofittedByFirewallManager` property set to true.
    /// For either case, any corresponding logging configuration will indicate
    /// `ManagedByFirewallManager`.
    managed_by_firewall_manager: bool = false,

    /// The parts of the request that you want to keep out of the logs.
    ///
    /// For example, if you
    /// redact the `SingleHeader` field, the `HEADER` field in the logs will
    /// be `REDACTED` for all rules that use the `SingleHeader`
    /// `FieldToMatch` setting.
    ///
    /// If you configure data protection for the web ACL, the protection applies to
    /// the data that WAF sends to the logs.
    ///
    /// Redaction applies only to the component that's specified in the rule's
    /// `FieldToMatch` setting, so the `SingleHeader` redaction
    /// doesn't apply to rules that use the `Headers`
    /// `FieldToMatch`.
    ///
    /// You can specify only the following fields for redaction: `UriPath`,
    /// `QueryString`, `SingleHeader`, and `Method`.
    ///
    /// This setting has no impact on request sampling. You can only exclude fields
    /// from request sampling by disabling sampling in the web ACL visibility
    /// configuration
    /// or by configuring data protection for the web ACL.
    redacted_fields: ?[]const FieldToMatch = null,

    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with
    /// `LogDestinationConfigs`.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .log_destination_configs = "LogDestinationConfigs",
        .logging_filter = "LoggingFilter",
        .log_scope = "LogScope",
        .log_type = "LogType",
        .managed_by_firewall_manager = "ManagedByFirewallManager",
        .redacted_fields = "RedactedFields",
        .resource_arn = "ResourceArn",
    };
};
