pub const ScaleDownBehavior = enum {
    terminate_at_instance_hour,
    terminate_at_task_completion,

    pub const json_field_names = .{
        .terminate_at_instance_hour = "TERMINATE_AT_INSTANCE_HOUR",
        .terminate_at_task_completion = "TERMINATE_AT_TASK_COMPLETION",
    };
};
