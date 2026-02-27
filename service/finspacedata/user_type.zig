pub const UserType = enum {
    super_user,
    app_user,

    pub const json_field_names = .{
        .super_user = "SUPER_USER",
        .app_user = "APP_USER",
    };
};
