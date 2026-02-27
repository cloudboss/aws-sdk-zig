pub const Role = enum {
    expert,
    moderator,
    administrator,
    supportrequestor,

    pub const json_field_names = .{
        .expert = "EXPERT",
        .moderator = "MODERATOR",
        .administrator = "ADMINISTRATOR",
        .supportrequestor = "SUPPORTREQUESTOR",
    };
};
