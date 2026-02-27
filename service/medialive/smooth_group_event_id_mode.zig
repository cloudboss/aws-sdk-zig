/// Smooth Group Event Id Mode
pub const SmoothGroupEventIdMode = enum {
    no_event_id,
    use_configured,
    use_timestamp,

    pub const json_field_names = .{
        .no_event_id = "NO_EVENT_ID",
        .use_configured = "USE_CONFIGURED",
        .use_timestamp = "USE_TIMESTAMP",
    };
};
