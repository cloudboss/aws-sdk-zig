pub const BillingViewType = enum {
    primary,
    billing_group,
    custom,
    billing_transfer,
    billing_transfer_showback,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .billing_group = "BILLING_GROUP",
        .custom = "CUSTOM",
        .billing_transfer = "BILLING_TRANSFER",
        .billing_transfer_showback = "BILLING_TRANSFER_SHOWBACK",
    };
};
