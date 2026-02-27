pub const AccessDeniedExceptionReason = enum {
    unauthorized_account,
    dependency_access_denied,

    pub const json_field_names = .{
        .unauthorized_account = "UNAUTHORIZED_ACCOUNT",
        .dependency_access_denied = "DEPENDENCY_ACCESS_DENIED",
    };
};
