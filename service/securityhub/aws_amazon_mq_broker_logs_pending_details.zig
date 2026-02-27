/// Provides information about logs to be activated for the specified broker.
pub const AwsAmazonMqBrokerLogsPendingDetails = struct {
    /// Activates audit logging. Every user management action made using JMX or the
    /// ActiveMQ Web Console is logged. Doesn't apply
    /// to RabbitMQ brokers.
    audit: ?bool,

    /// Activates general logging.
    general: ?bool,

    pub const json_field_names = .{
        .audit = "Audit",
        .general = "General",
    };
};
