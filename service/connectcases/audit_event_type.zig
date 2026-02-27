pub const AuditEventType = enum {
    case_created,
    case_updated,
    related_item_created,

    pub const json_field_names = .{
        .case_created = "CASE_CREATED",
        .case_updated = "CASE_UPDATED",
        .related_item_created = "RELATED_ITEM_CREATED",
    };
};
