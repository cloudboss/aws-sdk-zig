pub const UserType = enum {
    owner,
    user,

    pub const json_field_names = .{
        .owner = "OWNER",
        .user = "USER",
    };
};
