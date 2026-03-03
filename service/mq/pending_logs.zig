/// The list of information about logs to be enabled for the specified broker.
pub const PendingLogs = struct {
    /// Enables audit logging. Every user management action made using JMX or the
    /// ActiveMQ Web Console is logged.
    audit: ?bool = null,

    /// Enables general logging.
    general: ?bool = null,

    pub const json_field_names = .{
        .audit = "Audit",
        .general = "General",
    };
};
