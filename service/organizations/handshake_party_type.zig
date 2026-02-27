pub const HandshakePartyType = enum {
    account,
    organization,
    email,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .email = "EMAIL",
    };
};
