const AuditEventField = @import("audit_event_field.zig").AuditEventField;
const AuditEventPerformedBy = @import("audit_event_performed_by.zig").AuditEventPerformedBy;
const RelatedItemType = @import("related_item_type.zig").RelatedItemType;
const AuditEventType = @import("audit_event_type.zig").AuditEventType;

/// Represents the content of a particular audit event.
pub const AuditEvent = struct {
    /// Unique identifier of a case audit history event.
    event_id: []const u8,

    /// A list of Case Audit History event fields.
    fields: []const AuditEventField,

    /// Information of the user which performed the audit.
    performed_by: ?AuditEventPerformedBy,

    /// Time at which an Audit History event took place.
    performed_time: i64,

    /// The Type of the related item.
    related_item_type: ?RelatedItemType,

    /// The Type of an audit history event.
    type: AuditEventType,

    pub const json_field_names = .{
        .event_id = "eventId",
        .fields = "fields",
        .performed_by = "performedBy",
        .performed_time = "performedTime",
        .related_item_type = "relatedItemType",
        .type = "type",
    };
};
