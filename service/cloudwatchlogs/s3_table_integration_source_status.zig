pub const S3TableIntegrationSourceStatus = enum {
    active,
    unhealthy,
    failed,
    data_source_delete_in_progress,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .unhealthy = "UNHEALTHY",
        .failed = "FAILED",
        .data_source_delete_in_progress = "DATA_SOURCE_DELETE_IN_PROGRESS",
    };
};
