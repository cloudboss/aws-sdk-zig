pub const AccessLevelFilterKey = enum {
    account,
    role,
    user,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .role = "ROLE",
        .user = "USER",
    };
};
