pub const SortableFieldName = enum {
    initiation_timestamp,
    scheduled_timestamp,
    connected_to_agent_timestamp,
    disconnect_timestamp,
    initiation_method,
    channel,
    expiry_timestamp,

    pub const json_field_names = .{
        .initiation_timestamp = "INITIATION_TIMESTAMP",
        .scheduled_timestamp = "SCHEDULED_TIMESTAMP",
        .connected_to_agent_timestamp = "CONNECTED_TO_AGENT_TIMESTAMP",
        .disconnect_timestamp = "DISCONNECT_TIMESTAMP",
        .initiation_method = "INITIATION_METHOD",
        .channel = "CHANNEL",
        .expiry_timestamp = "EXPIRY_TIMESTAMP",
    };
};
