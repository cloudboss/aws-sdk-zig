pub const Type = enum {
    account,
    organization,
    account_unused_access,
    organization_unused_access,
    account_internal_access,
    organization_internal_access,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organization = "ORGANIZATION",
        .account_unused_access = "ACCOUNT_UNUSED_ACCESS",
        .organization_unused_access = "ORGANIZATION_UNUSED_ACCESS",
        .account_internal_access = "ACCOUNT_INTERNAL_ACCESS",
        .organization_internal_access = "ORGANIZATION_INTERNAL_ACCESS",
    };
};
