pub const ResponseTransferMode = enum {
    buffered,
    stream,

    pub const json_field_names = .{
        .buffered = "BUFFERED",
        .stream = "STREAM",
    };
};
