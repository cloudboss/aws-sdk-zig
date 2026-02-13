pub const MaintenanceWindowTaskCutoffBehavior = enum {
    continue_task,
    cancel_task,

    pub const json_field_names = .{
        .continue_task = "ContinueTask",
        .cancel_task = "CancelTask",
    };
};
