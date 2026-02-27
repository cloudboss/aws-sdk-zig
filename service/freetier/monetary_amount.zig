const CurrencyCode = @import("currency_code.zig").CurrencyCode;

/// The monetary amount of the credit.
pub const MonetaryAmount = struct {
    /// The aggregated monetary amount of credits earned.
    amount: f64 = 0,

    /// The unit that the monetary amount is given in.
    unit: CurrencyCode,

    pub const json_field_names = .{
        .amount = "amount",
        .unit = "unit",
    };
};
