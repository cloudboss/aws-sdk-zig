/// Monetary amounts associated with an invoice line item group.
pub const PricingCurrencyAmount = struct {
    /// The monetary amount before tax.
    amount: ?[]const u8 = null,

    /// The 3-letter ISO 4217 currency code (e.g., `USD`, `EUR`, `JPY`).
    currency_code: ?[]const u8 = null,

    /// The maximum refundable amount as a string representation of a decimal
    /// number.
    max_adjustment_amount: ?[]const u8 = null,

    pub const json_field_names = .{
        .amount = "amount",
        .currency_code = "currencyCode",
        .max_adjustment_amount = "maxAdjustmentAmount",
    };
};
