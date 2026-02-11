pub const InvokeMode = enum {
    buffered,
    response_stream,

    pub const json_field_names = .{
        .buffered = "BUFFERED",
        .response_stream = "RESPONSE_STREAM",
    };
};
