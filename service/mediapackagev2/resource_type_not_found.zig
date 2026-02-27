pub const ResourceTypeNotFound = enum {
    channel_group,
    channel,
    origin_endpoint,
    harvest_job,

    pub const json_field_names = .{
        .channel_group = "CHANNEL_GROUP",
        .channel = "CHANNEL",
        .origin_endpoint = "ORIGIN_ENDPOINT",
        .harvest_job = "HARVEST_JOB",
    };
};
