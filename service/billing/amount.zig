/// A monetary amount with a currency code. Used throughout the Billing API to
/// represent credit balances, allocations, and adjustments.
pub const Amount = struct {
    /// The amount as a decimal string (for example, `"743.21"`). Negative values
    /// represent credits that reduce a bill.
    currency_amount: []const u8,

    /// The ISO 4217 currency code for the amount (for example, `USD`).
    currency_code: []const u8,

    pub const json_field_names = .{
        .currency_amount = "currencyAmount",
        .currency_code = "currencyCode",
    };
};
