pub const ConfigurationLevel = enum {
    organization,
    account,

    pub const json_field_names = .{
        .organization = "ORGANIZATION",
        .account = "ACCOUNT",
    };
};
