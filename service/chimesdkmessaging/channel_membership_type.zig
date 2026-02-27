pub const ChannelMembershipType = enum {
    default,
    hidden,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .hidden = "HIDDEN",
    };
};
