pub const ExecutionClass = enum {
    flex,
    standard,

    pub const json_field_names = .{
        .flex = "FLEX",
        .standard = "STANDARD",
    };
};
