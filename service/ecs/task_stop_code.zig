pub const TaskStopCode = enum {
    task_failed_to_start,
    essential_container_exited,
    user_initiated,
    service_scheduler_initiated,
    spot_interruption,
    termination_notice,

    pub const json_field_names = .{
        .task_failed_to_start = "TASK_FAILED_TO_START",
        .essential_container_exited = "ESSENTIAL_CONTAINER_EXITED",
        .user_initiated = "USER_INITIATED",
        .service_scheduler_initiated = "SERVICE_SCHEDULER_INITIATED",
        .spot_interruption = "SPOT_INTERRUPTION",
        .termination_notice = "TERMINATION_NOTICE",
    };
};
