const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// Represents a monetary amount with associated currency.
pub const CostAmount = struct {
    /// The numeric value of the cost.
    amount: ?f64 = null,

    /// The currency code for the cost amount.
    currency: ?CurrencyCode = null,

    pub const json_field_names = .{
        .amount = "amount",
        .currency = "currency",
    };
};
