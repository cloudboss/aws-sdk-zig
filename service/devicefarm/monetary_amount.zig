const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// A number that represents the monetary amount for an offering or transaction.
pub const MonetaryAmount = struct {
    /// The numerical amount of an offering or transaction.
    amount: ?f64,

    /// The currency code of a monetary amount. For example, `USD` means U.S.
    /// dollars.
    currency_code: ?CurrencyCode,

    pub const json_field_names = .{
        .amount = "amount",
        .currency_code = "currencyCode",
    };
};
