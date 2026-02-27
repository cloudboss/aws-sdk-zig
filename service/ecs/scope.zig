pub const Scope = enum {
    task,
    shared,

    pub const json_field_names = .{
        .task = "TASK",
        .shared = "SHARED",
    };
};
