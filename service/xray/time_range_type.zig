pub const TimeRangeType = enum {
    trace_id,
    event,
    service,

    pub const json_field_names = .{
        .trace_id = "TraceId",
        .event = "Event",
        .service = "Service",
    };
};
