pub const MemberType = enum {
    user,
    group,
    computer,

    pub const json_field_names = .{
        .user = "USER",
        .group = "GROUP",
        .computer = "COMPUTER",
    };
};
