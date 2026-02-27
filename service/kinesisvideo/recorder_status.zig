pub const RecorderStatus = enum {
    success,
    user_error,
    system_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .user_error = "USER_ERROR",
        .system_error = "SYSTEM_ERROR",
    };
};
