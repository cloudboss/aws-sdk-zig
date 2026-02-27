pub const AccountType = enum {
    management,
    member,

    pub const json_field_names = .{
        .management = "MANAGEMENT",
        .member = "MEMBER",
    };
};
