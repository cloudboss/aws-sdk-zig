pub const StepLifecycleStatus = enum {
    create_complete,
    update_in_progress,
    update_failed,
    update_succeeded,

    pub const json_field_names = .{
        .create_complete = "CREATE_COMPLETE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_failed = "UPDATE_FAILED",
        .update_succeeded = "UPDATE_SUCCEEDED",
    };
};
