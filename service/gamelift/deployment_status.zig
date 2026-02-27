pub const DeploymentStatus = enum {
    in_progress,
    impaired,
    complete,
    rollback_in_progress,
    rollback_complete,
    cancelled,
    pending,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .impaired = "IMPAIRED",
        .complete = "COMPLETE",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .cancelled = "CANCELLED",
        .pending = "PENDING",
    };
};
