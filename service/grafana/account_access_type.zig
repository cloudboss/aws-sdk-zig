pub const AccountAccessType = enum {
    /// Indicates that the customer is using Grafana to monitor resources in their
    /// current account.
    current_account,
    /// Indicates that the customer is using Grafana to monitor resources in
    /// organizational units.
    organization,

    pub const json_field_names = .{
        .current_account = "CURRENT_ACCOUNT",
        .organization = "ORGANIZATION",
    };
};
