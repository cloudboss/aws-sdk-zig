const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// Represents a monetary amount with its associated currency.
pub const MonetaryValue = struct {
    /// The numeric amount of the monetary value.
    amount: []const u8,

    /// The ISO 4217 currency code (e.g., USD, EUR) for the monetary amount.
    currency_code: CurrencyCode,

    pub const json_field_names = .{
        .amount = "Amount",
        .currency_code = "CurrencyCode",
    };
};
