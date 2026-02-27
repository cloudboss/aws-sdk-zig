pub const UserSortType = enum {
    user_name,
    full_name,
    storage_limit,
    user_status,
    storage_used,

    pub const json_field_names = .{
        .user_name = "USER_NAME",
        .full_name = "FULL_NAME",
        .storage_limit = "STORAGE_LIMIT",
        .user_status = "USER_STATUS",
        .storage_used = "STORAGE_USED",
    };
};
