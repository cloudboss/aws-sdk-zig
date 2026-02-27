pub const PhoneNumberStatus = enum {
    cancelled,
    portin_cancel_requested,
    portin_in_progress,
    acquire_in_progress,
    acquire_failed,
    unassigned,
    assigned,
    release_in_progress,
    delete_in_progress,
    release_failed,
    delete_failed,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .portin_cancel_requested = "PortinCancelRequested",
        .portin_in_progress = "PortinInProgress",
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
