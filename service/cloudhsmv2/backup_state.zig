pub const BackupState = enum {
    create_in_progress,
    ready,
    deleted,
    pending_deletion,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .ready = "READY",
        .deleted = "DELETED",
        .pending_deletion = "PENDING_DELETION",
    };
};
