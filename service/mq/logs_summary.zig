const PendingLogs = @import("pending_logs.zig").PendingLogs;

/// The list of information about logs currently enabled and pending to be
/// deployed for the specified broker.
pub const LogsSummary = struct {
    /// Enables audit logging. Every user management action made using JMX or the
    /// ActiveMQ Web Console is logged.
    audit: ?bool,

    /// The location of the CloudWatch Logs log group where audit logs are sent.
    audit_log_group: ?[]const u8,

    /// Enables general logging.
    general: bool,

    /// The location of the CloudWatch Logs log group where general logs are sent.
    general_log_group: []const u8,

    /// The list of information about logs pending to be deployed for the specified
    /// broker.
    pending: ?PendingLogs,

    pub const json_field_names = .{
        .audit = "Audit",
        .audit_log_group = "AuditLogGroup",
        .general = "General",
        .general_log_group = "GeneralLogGroup",
        .pending = "Pending",
    };
};
