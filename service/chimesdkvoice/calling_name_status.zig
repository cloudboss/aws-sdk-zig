pub const CallingNameStatus = enum {
    unassigned,
    update_in_progress,
    update_succeeded,
    update_failed,

    pub const json_field_names = .{
        .unassigned = "Unassigned",
        .update_in_progress = "UpdateInProgress",
        .update_succeeded = "UpdateSucceeded",
        .update_failed = "UpdateFailed",
    };
};
