pub const RStudioServerProUserGroup = enum {
    admin,
    user,

    pub const json_field_names = .{
        .admin = "Admin",
        .user = "User",
    };
};
