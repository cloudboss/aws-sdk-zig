const AuditEventFieldValueUnion = @import("audit_event_field_value_union.zig").AuditEventFieldValueUnion;

/// Fields for audit event.
pub const AuditEventField = struct {
    /// Unique identifier of field in an Audit History entry.
    event_field_id: []const u8,

    /// Union of potential field value types.
    new_value: AuditEventFieldValueUnion,

    /// Union of potential field value types.
    old_value: ?AuditEventFieldValueUnion = null,

    pub const json_field_names = .{
        .event_field_id = "eventFieldId",
        .new_value = "newValue",
        .old_value = "oldValue",
    };
};
