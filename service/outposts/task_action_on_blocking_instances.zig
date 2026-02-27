pub const TaskActionOnBlockingInstances = enum {
    wait_for_evacuation,
    fail_task,

    pub const json_field_names = .{
        .wait_for_evacuation = "WAIT_FOR_EVACUATION",
        .fail_task = "FAIL_TASK",
    };
};
