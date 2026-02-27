pub const ResourceType = enum {
    data_set,
    revision,
    asset,
    job,
    event_action,
    data_grant,

    pub const json_field_names = .{
        .data_set = "DATA_SET",
        .revision = "REVISION",
        .asset = "ASSET",
        .job = "JOB",
        .event_action = "EVENT_ACTION",
        .data_grant = "DATA_GRANT",
    };
};
