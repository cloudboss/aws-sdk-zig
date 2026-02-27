pub const ExecutionType = enum {
    standard,
    rollback,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .rollback = "ROLLBACK",
    };
};
