/// A time range for which the margin summary is effective. The time range can
/// be up to 12 months.
pub const BillingPeriodRange = struct {
    /// The exclusive end billing period that defines a billing period range for the
    /// margin summary. For example, if you choose a billing period that starts in
    /// October 2023 and ends in December 2023, the margin summary will only include
    /// data from October 2023 and November 2023.
    exclusive_end_billing_period: []const u8,

    /// The inclusive start billing period that defines a billing period range for
    /// the margin summary.
    inclusive_start_billing_period: []const u8,

    pub const json_field_names = .{
        .exclusive_end_billing_period = "ExclusiveEndBillingPeriod",
        .inclusive_start_billing_period = "InclusiveStartBillingPeriod",
    };
};
