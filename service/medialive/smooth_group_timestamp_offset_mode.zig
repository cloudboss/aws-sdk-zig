/// Smooth Group Timestamp Offset Mode
pub const SmoothGroupTimestampOffsetMode = enum {
    use_configured_offset,
    use_event_start_date,

    pub const json_field_names = .{
        .use_configured_offset = "USE_CONFIGURED_OFFSET",
        .use_event_start_date = "USE_EVENT_START_DATE",
    };
};
