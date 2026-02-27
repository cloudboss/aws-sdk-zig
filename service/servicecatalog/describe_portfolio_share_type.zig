pub const DescribePortfolioShareType = enum {
    account,
    organization,
    organizational_unit,
    organization_member_account,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
        .organization_member_account = "ORGANIZATION_MEMBER_ACCOUNT",
    };
};
