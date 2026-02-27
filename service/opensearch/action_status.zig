pub const ActionStatus = enum {
    pending_update,
    in_progress,
    failed,
    completed,
    not_eligible,
    eligible,

    pub const json_field_names = .{
        .pending_update = "PENDING_UPDATE",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .not_eligible = "NOT_ELIGIBLE",
        .eligible = "ELIGIBLE",
    };
};
