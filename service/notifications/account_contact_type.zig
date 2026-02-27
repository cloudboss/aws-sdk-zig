pub const AccountContactType = enum {
    /// Primary Contact managed by AWS Account Management Service.
    account_primary,
    /// Alternate Billing Contact managed by AWS Account Management Service.
    account_alternate_billing,
    /// Alternate Operations Contact managed by AWS Account Management Service.
    account_alternate_operations,
    /// Alternate Security Contact managed by AWS Account Management Service.
    account_alternate_security,

    pub const json_field_names = .{
        .account_primary = "ACCOUNT_PRIMARY",
        .account_alternate_billing = "ACCOUNT_ALTERNATE_BILLING",
        .account_alternate_operations = "ACCOUNT_ALTERNATE_OPERATIONS",
        .account_alternate_security = "ACCOUNT_ALTERNATE_SECURITY",
    };
};
