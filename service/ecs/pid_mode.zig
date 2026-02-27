pub const PidMode = enum {
    host,
    task,

    pub const json_field_names = .{
        .host = "HOST",
        .task = "TASK",
    };
};
