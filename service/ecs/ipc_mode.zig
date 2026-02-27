pub const IpcMode = enum {
    host,
    task,
    none,

    pub const json_field_names = .{
        .host = "HOST",
        .task = "TASK",
        .none = "NONE",
    };
};
