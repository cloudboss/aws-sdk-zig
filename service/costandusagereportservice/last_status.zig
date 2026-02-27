pub const LastStatus = enum {
    success,
    error_permissions,
    error_no_bucket,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .error_permissions = "ERROR_PERMISSIONS",
        .error_no_bucket = "ERROR_NO_BUCKET",
    };
};
