const AwsAmazonMqBrokerLogsPendingDetails = @import("aws_amazon_mq_broker_logs_pending_details.zig").AwsAmazonMqBrokerLogsPendingDetails;

/// Provides information about logs to be activated for the specified broker.
pub const AwsAmazonMqBrokerLogsDetails = struct {
    /// Activates audit logging. Every user management action made using JMX or the
    /// ActiveMQ Web Console is logged. Doesn't apply to RabbitMQ brokers.
    audit: ?bool,

    /// The location of the CloudWatch Logs log group where audit logs are sent.
    audit_log_group: ?[]const u8,

    /// Activates general logging.
    general: ?bool,

    /// The location of the CloudWatch Logs log group where general logs are sent.
    general_log_group: ?[]const u8,

    /// The list of information about logs that are to be turned on for the
    /// specified broker.
    pending: ?AwsAmazonMqBrokerLogsPendingDetails,

    pub const json_field_names = .{
        .audit = "Audit",
        .audit_log_group = "AuditLogGroup",
        .general = "General",
        .general_log_group = "GeneralLogGroup",
        .pending = "Pending",
    };
};
