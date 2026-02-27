pub const LogExport = enum {
    user_activity_log,
    user_log,
    connection_log,

    pub const json_field_names = .{
        .user_activity_log = "USER_ACTIVITY_LOG",
        .user_log = "USER_LOG",
        .connection_log = "CONNECTION_LOG",
    };
};
