pub const GuardrailOrigin = enum {
    request,
    account_enforced,
    organization_enforced,

    pub const json_field_names = .{
        .request = "REQUEST",
        .account_enforced = "ACCOUNT_ENFORCED",
        .organization_enforced = "ORGANIZATION_ENFORCED",
    };
};
