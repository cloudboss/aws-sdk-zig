pub const TraceFormatType = enum {
    xray,
    otel,

    pub const json_field_names = .{
        .xray = "XRAY",
        .otel = "OTEL",
    };
};
