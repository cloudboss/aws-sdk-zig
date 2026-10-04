/// A custom tier for the pricing rule. Each custom tier applies a rate to the
/// usage that falls within the tier's range.
pub const CustomTier = struct {
    /// The inclusive start of the usage range that this tier applies to.
    begin_range_inclusive: f64,

    /// The exclusive end of the usage range that this tier applies to. If you don't
    /// specify a value, this tier applies to all usage that is greater than or
    /// equal to `BeginRangeInclusive`.
    end_range_exclusive: ?f64 = null,

    /// The rate that's applied to the usage that falls within this tier.
    rate_value: f64,

    pub const json_field_names = .{
        .begin_range_inclusive = "BeginRangeInclusive",
        .end_range_exclusive = "EndRangeExclusive",
        .rate_value = "RateValue",
    };
};
