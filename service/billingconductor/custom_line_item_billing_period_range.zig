/// The billing period range in which the custom line item request will be
/// applied.
pub const CustomLineItemBillingPeriodRange = struct {
    /// The inclusive end billing period that defines a billing period range where a
    /// custom line is applied.
    exclusive_end_billing_period: ?[]const u8 = null,

    /// The inclusive start billing period that defines a billing period range where
    /// a custom line is applied.
    inclusive_start_billing_period: []const u8,

    pub const json_field_names = .{
        .exclusive_end_billing_period = "ExclusiveEndBillingPeriod",
        .inclusive_start_billing_period = "InclusiveStartBillingPeriod",
    };
};
