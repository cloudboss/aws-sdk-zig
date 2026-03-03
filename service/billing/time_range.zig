/// Specifies a time range with inclusive begin and end dates.
pub const TimeRange = struct {
    /// The inclusive start date of the time range.
    begin_date_inclusive: ?i64 = null,

    /// The inclusive end date of the time range.
    end_date_inclusive: ?i64 = null,

    pub const json_field_names = .{
        .begin_date_inclusive = "beginDateInclusive",
        .end_date_inclusive = "endDateInclusive",
    };
};
