pub const SpanType = enum {
    client,
    server,
    internal,

    pub const json_field_names = .{
        .client = "CLIENT",
        .server = "SERVER",
        .internal = "INTERNAL",
    };
};
