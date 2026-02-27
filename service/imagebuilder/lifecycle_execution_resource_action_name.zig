pub const LifecycleExecutionResourceActionName = enum {
    available,
    delete,
    deprecate,
    disable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .delete = "DELETE",
        .deprecate = "DEPRECATE",
        .disable = "DISABLE",
    };
};
