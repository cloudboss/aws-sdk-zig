/// A billing period filter that specifies the custom line item versions to
/// retrieve.
pub const ListCustomLineItemVersionsBillingPeriodRangeFilter = struct {
    /// The exclusive end billing period that defines a billing period range where a
    /// custom line item version is applied.
    end_billing_period: ?[]const u8,

    /// The inclusive start billing period that defines a billing period range where
    /// a custom line item version is applied.
    start_billing_period: ?[]const u8,

    pub const json_field_names = .{
        .end_billing_period = "EndBillingPeriod",
        .start_billing_period = "StartBillingPeriod",
    };
};
