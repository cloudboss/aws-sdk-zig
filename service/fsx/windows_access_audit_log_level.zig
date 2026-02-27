pub const WindowsAccessAuditLogLevel = enum {
    disabled,
    success_only,
    failure_only,
    success_and_failure,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .success_only = "SUCCESS_ONLY",
        .failure_only = "FAILURE_ONLY",
        .success_and_failure = "SUCCESS_AND_FAILURE",
    };
};
