const AuditLogProcessingConfiguration = @import("audit_log_processing_configuration.zig").AuditLogProcessingConfiguration;

/// Contains information about how ingested data is processed.
pub const ProcessingConfiguration = union(enum) {
    /// Contains information about an audit log processing configuration.
    audit_log: ?AuditLogProcessingConfiguration,

    pub const json_field_names = .{
        .audit_log = "auditLog",
    };
};
