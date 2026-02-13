pub const ExecutionMode = enum {
    auto,
    interactive,

    pub const json_field_names = .{
        .auto = "Auto",
        .interactive = "Interactive",
    };
};
