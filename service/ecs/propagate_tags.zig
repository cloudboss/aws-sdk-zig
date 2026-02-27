pub const PropagateTags = enum {
    task_definition,
    service,
    none,

    pub const json_field_names = .{
        .task_definition = "TASK_DEFINITION",
        .service = "SERVICE",
        .none = "NONE",
    };
};
