pub const RecommenderStatus = enum {
    pending,
    in_progress,
    active,
    failed,
    stopping,
    inactive,
    starting,
    deleting,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .active = "ACTIVE",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .inactive = "INACTIVE",
        .starting = "STARTING",
        .deleting = "DELETING",
    };
};
