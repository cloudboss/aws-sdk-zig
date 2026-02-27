pub const QueueFleetAssociationStatus = enum {
    active,
    stop_scheduling_and_complete_tasks,
    stop_scheduling_and_cancel_tasks,
    stopped,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .stop_scheduling_and_complete_tasks = "STOP_SCHEDULING_AND_COMPLETE_TASKS",
        .stop_scheduling_and_cancel_tasks = "STOP_SCHEDULING_AND_CANCEL_TASKS",
        .stopped = "STOPPED",
    };
};
