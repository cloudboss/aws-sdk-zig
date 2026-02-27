pub const RetryBuildBatchType = enum {
    retry_all_builds,
    retry_failed_builds,

    pub const json_field_names = .{
        .retry_all_builds = "RETRY_ALL_BUILDS",
        .retry_failed_builds = "RETRY_FAILED_BUILDS",
    };
};
