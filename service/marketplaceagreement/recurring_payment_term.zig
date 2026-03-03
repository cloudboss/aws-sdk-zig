/// Defines a pricing model where customers are charged a fixed recurring price
/// at the end of each billing period.
pub const RecurringPaymentTerm = struct {
    /// Defines the recurrence at which buyers are charged.
    billing_period: ?[]const u8 = null,

    /// Defines the currency for the prices mentioned in this term.
    currency_code: ?[]const u8 = null,

    /// Amount charged to the buyer every billing period.
    price: ?[]const u8 = null,

    /// Type of the term being updated.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_period = "billingPeriod",
        .currency_code = "currencyCode",
        .price = "price",
        .@"type" = "type",
    };
};
