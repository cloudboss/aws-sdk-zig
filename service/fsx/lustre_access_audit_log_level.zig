pub const LustreAccessAuditLogLevel = enum {
    disabled,
    warn_only,
    error_only,
    warn_error,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .warn_only = "WARN_ONLY",
        .error_only = "ERROR_ONLY",
        .warn_error = "WARN_ERROR",
    };
};
