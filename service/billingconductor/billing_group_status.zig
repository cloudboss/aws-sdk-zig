pub const BillingGroupStatus = enum {
    active,
    primary_account_missing,
    pending,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .primary_account_missing = "PRIMARY_ACCOUNT_MISSING",
        .pending = "PENDING",
    };
};
