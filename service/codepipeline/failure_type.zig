pub const FailureType = enum {
    job_failed,
    configuration_error,
    permission_error,
    revision_out_of_sync,
    revision_unavailable,
    system_unavailable,

    pub const json_field_names = .{
        .job_failed = "JobFailed",
        .configuration_error = "ConfigurationError",
        .permission_error = "PermissionError",
        .revision_out_of_sync = "RevisionOutOfSync",
        .revision_unavailable = "RevisionUnavailable",
        .system_unavailable = "SystemUnavailable",
    };
};
