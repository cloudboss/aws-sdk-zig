const AuditTargetEntity = @import("audit_target_entity.zig").AuditTargetEntity;

/// A structure that specifies the target entity for audit analysis, such as a
/// `service`, `SLO`, `service_operation`, or `canary`.
pub const AuditTarget = struct {
    /// The specific data identifying the audit target entity.
    data: AuditTargetEntity,

    /// The type of entity being audited, such as `service`, `SLO`,
    /// `service_operation`, or `canary`.
    type: []const u8,

    pub const json_field_names = .{
        .data = "Data",
        .type = "Type",
    };
};
