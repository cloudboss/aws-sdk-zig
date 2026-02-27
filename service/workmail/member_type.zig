pub const MemberType = enum {
    group,
    user,

    pub const json_field_names = .{
        .group = "GROUP",
        .user = "USER",
    };
};
