const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;

/// Describes the limit price of a Reserved Instance offering.
pub const ReservedInstanceLimitPrice = struct {
    /// Used for Reserved Instance Marketplace offerings. Specifies the limit price
    /// on the total
    /// order (instanceCount * price).
    amount: ?f64,

    /// The currency in which the `limitPrice` amount is specified. At this time,
    /// the
    /// only supported currency is `USD`.
    currency_code: ?CurrencyCodeValues,
};
