pub const CustomerPolicyScopeIdType = enum {
    account,
    org_unit,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .org_unit = "ORG_UNIT",
    };
};
