pub const InstanceFleetType = enum {
    master,
    core,
    task,

    pub const json_field_names = .{
        .master = "MASTER",
        .core = "CORE",
        .task = "TASK",
    };
};
