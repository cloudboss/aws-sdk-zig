pub const UserRole = enum {
    user,
    resource,
    system_user,
    remote_user,

    pub const json_field_names = .{
        .user = "USER",
        .resource = "RESOURCE",
        .system_user = "SYSTEM_USER",
        .remote_user = "REMOTE_USER",
    };
};
