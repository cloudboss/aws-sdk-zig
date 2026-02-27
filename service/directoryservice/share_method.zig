pub const ShareMethod = enum {
    organizations,
    handshake,

    pub const json_field_names = .{
        .organizations = "ORGANIZATIONS",
        .handshake = "HANDSHAKE",
    };
};
