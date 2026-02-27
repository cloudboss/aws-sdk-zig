pub const TrainingDataSourceEnum = enum {
    external_events,
    ingested_events,

    pub const json_field_names = .{
        .external_events = "EXTERNAL_EVENTS",
        .ingested_events = "INGESTED_EVENTS",
    };
};
