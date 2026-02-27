pub const UpdateQueueLimitAssociationStatus = enum {
    active,
    stop_limit_usage_and_complete_tasks,
    stop_limit_usage_and_cancel_tasks,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .stop_limit_usage_and_complete_tasks = "STOP_LIMIT_USAGE_AND_COMPLETE_TASKS",
        .stop_limit_usage_and_cancel_tasks = "STOP_LIMIT_USAGE_AND_CANCEL_TASKS",
    };
};
