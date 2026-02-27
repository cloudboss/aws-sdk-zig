const AuditLogDestinationConfiguration = @import("audit_log_destination_configuration.zig").AuditLogDestinationConfiguration;

/// Contains information about the destination of ingested data.
pub const DestinationConfiguration = union(enum) {
    /// Contains information about an audit log destination configuration.
    audit_log: ?AuditLogDestinationConfiguration,

    pub const json_field_names = .{
        .audit_log = "auditLog",
    };
};
