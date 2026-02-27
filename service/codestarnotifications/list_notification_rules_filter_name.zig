pub const ListNotificationRulesFilterName = enum {
    event_type_id,
    created_by,
    resource,
    target_address,

    pub const json_field_names = .{
        .event_type_id = "EVENT_TYPE_ID",
        .created_by = "CREATED_BY",
        .resource = "RESOURCE",
        .target_address = "TARGET_ADDRESS",
    };
};
