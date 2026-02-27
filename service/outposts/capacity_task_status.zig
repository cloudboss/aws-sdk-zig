pub const CapacityTaskStatus = enum {
    requested,
    in_progress,
    failed,
    completed,
    waiting_for_evacuation,
    cancellation_in_progress,
    cancelled,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .waiting_for_evacuation = "WAITING_FOR_EVACUATION",
        .cancellation_in_progress = "CANCELLATION_IN_PROGRESS",
        .cancelled = "CANCELLED",
    };
};
