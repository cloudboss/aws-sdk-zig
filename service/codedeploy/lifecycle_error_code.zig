pub const LifecycleErrorCode = enum {
    success,
    script_missing,
    script_not_executable,
    script_timed_out,
    script_failed,
    unknown_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .script_missing = "SCRIPT_MISSING",
        .script_not_executable = "SCRIPT_NOT_EXECUTABLE",
        .script_timed_out = "SCRIPT_TIMED_OUT",
        .script_failed = "SCRIPT_FAILED",
        .unknown_error = "UNKNOWN_ERROR",
    };
};
