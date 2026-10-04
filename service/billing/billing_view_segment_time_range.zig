/// Specifies a time range with an inclusive begin date and an exclusive end
/// date.
pub const BillingViewSegmentTimeRange = struct {
    /// The inclusive start of the time range. This value can't be in the future.
    begin_date_inclusive: ?i64 = null,

    /// The exclusive end of the time range. This value must be after
    /// `beginDateInclusive`.
    end_date_exclusive: ?i64 = null,

    pub const json_field_names = .{
        .begin_date_inclusive = "beginDateInclusive",
        .end_date_exclusive = "endDateExclusive",
    };
};
