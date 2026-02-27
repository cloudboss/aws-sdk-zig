pub const ApplicationMode = enum {
    streaming,
    interactive,

    pub const json_field_names = .{
        .streaming = "STREAMING",
        .interactive = "INTERACTIVE",
    };
};
