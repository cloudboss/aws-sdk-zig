pub const LicenseEndpointStatus = enum {
    create_in_progress,
    delete_in_progress,
    ready,
    not_ready,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .ready = "READY",
        .not_ready = "NOT_READY",
    };
};
