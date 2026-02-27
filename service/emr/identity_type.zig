pub const IdentityType = enum {
    user,
    group,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
    };
};
