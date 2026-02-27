pub const SessionLifecycleStatus = enum {
    started,
    update_in_progress,
    update_succeeded,
    update_failed,
    ended,

    pub const json_field_names = .{
        .started = "STARTED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_succeeded = "UPDATE_SUCCEEDED",
        .update_failed = "UPDATE_FAILED",
        .ended = "ENDED",
    };
};
