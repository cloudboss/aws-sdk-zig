const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;

/// Describes the price for a Reserved Instance.
pub const PriceScheduleSpecification = struct {
    /// The currency for transacting the Reserved Instance resale. At this time, the
    /// only
    /// supported currency is `USD`.
    currency_code: ?CurrencyCodeValues,

    /// The fixed price for the term.
    price: ?f64,

    /// The number of months remaining in the reservation. For example, 2 is the
    /// second to the
    /// last month before the capacity reservation expires.
    term: ?i64,
};
