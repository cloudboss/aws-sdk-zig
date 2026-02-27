pub const PhoneNumberStatus = enum {
    acquire_in_progress,
    acquire_failed,
    unassigned,
    assigned,
    release_in_progress,
    delete_in_progress,
    release_failed,
    delete_failed,

    pub const json_field_names = .{
        .acquire_in_progress = "AcquireInProgress",
        .acquire_failed = "AcquireFailed",
        .unassigned = "Unassigned",
        .assigned = "Assigned",
        .release_in_progress = "ReleaseInProgress",
        .delete_in_progress = "DeleteInProgress",
        .release_failed = "ReleaseFailed",
        .delete_failed = "DeleteFailed",
    };
};
