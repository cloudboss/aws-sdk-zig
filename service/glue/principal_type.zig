pub const PrincipalType = enum {
    user,
    role,
    group,

    pub const json_field_names = .{
        .user = "USER",
        .role = "ROLE",
        .group = "GROUP",
    };
};
