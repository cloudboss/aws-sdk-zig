pub const LookupAttributeKey = enum {
    event_id,
    event_name,
    read_only,
    username,
    resource_type,
    resource_name,
    event_source,
    access_key_id,

    pub const json_field_names = .{
        .event_id = "EVENT_ID",
        .event_name = "EVENT_NAME",
        .read_only = "READ_ONLY",
        .username = "USERNAME",
        .resource_type = "RESOURCE_TYPE",
        .resource_name = "RESOURCE_NAME",
        .event_source = "EVENT_SOURCE",
        .access_key_id = "ACCESS_KEY_ID",
    };
};
