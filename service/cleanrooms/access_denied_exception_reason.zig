pub const AccessDeniedExceptionReason = enum {
    insufficient_permissions,

    pub const json_field_names = .{
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
    };
};
