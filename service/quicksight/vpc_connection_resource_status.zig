pub const VPCConnectionResourceStatus = enum {
    creation_in_progress,
    creation_successful,
    creation_failed,
    update_in_progress,
    update_successful,
    update_failed,
    deletion_in_progress,
    deletion_failed,
    deleted,

    pub const json_field_names = .{
        .creation_in_progress = "CREATION_IN_PROGRESS",
        .creation_successful = "CREATION_SUCCESSFUL",
        .creation_failed = "CREATION_FAILED",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .update_successful = "UPDATE_SUCCESSFUL",
        .update_failed = "UPDATE_FAILED",
        .deletion_in_progress = "DELETION_IN_PROGRESS",
        .deletion_failed = "DELETION_FAILED",
        .deleted = "DELETED",
    };
};
