pub const ListCisScansDetailLevel = enum {
    organization,
    member,

    pub const json_field_names = .{
        .organization = "ORGANIZATION",
        .member = "MEMBER",
    };
};
