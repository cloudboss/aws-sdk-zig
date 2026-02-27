pub const AudienceExportJobStatus = enum {
    create_pending,
    create_in_progress,
    create_failed,
    active,

    pub const json_field_names = .{
        .create_pending = "CREATE_PENDING",
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
    };
};
