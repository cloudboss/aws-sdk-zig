const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// Represents a monetary amount with associated currency.
pub const CostAmount = struct {
    /// The numeric value of the cost.
    amount: ?f64,

    /// The currency code for the cost amount.
    currency: ?CurrencyCode,

    pub const json_field_names = .{
        .amount = "amount",
        .currency = "currency",
    };
};
