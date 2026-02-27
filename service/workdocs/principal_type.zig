pub const PrincipalType = enum {
    user,
    group,
    invite,
    anonymous,
    organization,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
        .invite = "INVITE",
        .anonymous = "ANONYMOUS",
        .organization = "ORGANIZATION",
    };
};
