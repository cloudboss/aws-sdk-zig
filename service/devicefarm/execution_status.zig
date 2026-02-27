pub const ExecutionStatus = enum {
    pending,
    pending_concurrnecy,
    pending_device,
    processing,
    scheduling,
    preparing,
    running,
    completed,
    stopping,

    pub const json_field_names = .{
        .pending = "PENDING",
        .pending_concurrnecy = "PENDING_CONCURRNECY",
        .pending_device = "PENDING_DEVICE",
        .processing = "PROCESSING",
        .scheduling = "SCHEDULING",
        .preparing = "PREPARING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
    };
};
