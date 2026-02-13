pub const SessionFilterKey = enum {
    invoked_after,
    invoked_before,
    target_id,
    owner,
    status,
    session_id,
    access_type,

    pub const json_field_names = .{
        .invoked_after = "INVOKED_AFTER",
        .invoked_before = "INVOKED_BEFORE",
        .target_id = "TARGET_ID",
        .owner = "OWNER",
        .status = "STATUS",
        .session_id = "SESSION_ID",
        .access_type = "ACCESS_TYPE",
    };
};
