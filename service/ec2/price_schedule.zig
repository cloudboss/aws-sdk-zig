const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;

/// Describes the price for a Reserved Instance.
pub const PriceSchedule = struct {
    /// The current price schedule, as determined by the term remaining for the
    /// Reserved Instance
    /// in the listing.
    ///
    /// A specific price schedule is always in effect, but only one price schedule
    /// can be active
    /// at any time. Take, for example, a Reserved Instance listing that has five
    /// months remaining in
    /// its term. When you specify price schedules for five months and two months,
    /// this means that
    /// schedule 1, covering the first three months of the remaining term, will be
    /// active during
    /// months 5, 4, and 3. Then schedule 2, covering the last two months of the
    /// term, will be active
    /// for months 2 and 1.
    active: ?bool,

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
