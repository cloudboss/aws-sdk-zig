/// The list of information about logs to be enabled for the specified broker.
pub const Logs = struct {
    /// Enables audit logging. Every user management action made using JMX or the
    /// ActiveMQ Web Console is logged. Does not apply to RabbitMQ brokers.
    audit: ?bool,

    /// Enables general logging.
    general: ?bool,

    pub const json_field_names = .{
        .audit = "Audit",
        .general = "General",
    };
};
