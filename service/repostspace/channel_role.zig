pub const ChannelRole = enum {
    asker,
    expert,
    moderator,
    supportrequestor,

    pub const json_field_names = .{
        .asker = "ASKER",
        .expert = "EXPERT",
        .moderator = "MODERATOR",
        .supportrequestor = "SUPPORTREQUESTOR",
    };
};
