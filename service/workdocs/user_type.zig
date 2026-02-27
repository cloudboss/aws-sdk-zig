pub const UserType = enum {
    user,
    admin,
    poweruser,
    minimaluser,
    workspacesuser,

    pub const json_field_names = .{
        .user = "USER",
        .admin = "ADMIN",
        .poweruser = "POWERUSER",
        .minimaluser = "MINIMALUSER",
        .workspacesuser = "WORKSPACESUSER",
    };
};
