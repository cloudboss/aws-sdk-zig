pub const OrganizationNodeType = enum {
    organization,
    organizational_unit,
    account,

    pub const json_field_names = .{
        .organization = "ORGANIZATION",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
        .account = "ACCOUNT",
    };
};
