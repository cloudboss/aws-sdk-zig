pub const JobEventType = enum {
    waiting_for_priority,
    queued_for_execution,
    starting_instance,
    downloading_data,
    running,
    deprioritized_due_to_inactivity,
    uploading_results,
    completed,
    failed,
    max_runtime_exceeded,
    cancelled,

    pub const json_field_names = .{
        .waiting_for_priority = "WAITING_FOR_PRIORITY",
        .queued_for_execution = "QUEUED_FOR_EXECUTION",
        .starting_instance = "STARTING_INSTANCE",
        .downloading_data = "DOWNLOADING_DATA",
        .running = "RUNNING",
        .deprioritized_due_to_inactivity = "DEPRIORITIZED_DUE_TO_INACTIVITY",
        .uploading_results = "UPLOADING_RESULTS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .max_runtime_exceeded = "MAX_RUNTIME_EXCEEDED",
        .cancelled = "CANCELLED",
    };
};
