pub const RecommendationJobStatus = enum {
    pending,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
