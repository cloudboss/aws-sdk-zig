pub const OrderBy = enum {
    log_stream_name,
    last_event_time,

    pub const json_field_names = .{
        .log_stream_name = "LogStreamName",
        .last_event_time = "LastEventTime",
    };
};
