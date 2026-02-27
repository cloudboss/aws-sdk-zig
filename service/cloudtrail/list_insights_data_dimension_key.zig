pub const ListInsightsDataDimensionKey = enum {
    event_id,
    event_name,
    event_source,

    pub const json_field_names = .{
        .event_id = "EVENT_ID",
        .event_name = "EVENT_NAME",
        .event_source = "EVENT_SOURCE",
    };
};
