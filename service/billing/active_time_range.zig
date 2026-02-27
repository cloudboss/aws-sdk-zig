/// A time range with a start and end time.
pub const ActiveTimeRange = struct {
    /// The inclusive time range start date.
    active_after_inclusive: i64,

    /// The inclusive time range end date.
    active_before_inclusive: i64,

    pub const json_field_names = .{
        .active_after_inclusive = "activeAfterInclusive",
        .active_before_inclusive = "activeBeforeInclusive",
    };
};
