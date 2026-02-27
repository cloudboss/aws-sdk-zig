/// Sets the start date and end date for retrieving a cost estimate. The start
/// date is
/// inclusive, but the end date is exclusive. For example, if `start` is
/// `2017-01-01` and `end` is `2017-05-01`, then the cost and
/// usage data is retrieved from `2017-01-01` up to and including
/// `2017-04-30` but not including `2017-05-01`.
pub const TimePeriod = struct {
    /// The end of the time period. The end date is exclusive. For example, if `end`
    /// is
    /// `2017-05-01`, Lightsail for Research retrieves cost and usage data from the
    /// start date up to, but
    /// not including, `2017-05-01`.
    end: ?i64,

    /// The beginning of the time period. The start date is inclusive. For example,
    /// if
    /// `start` is `2017-01-01`, Lightsail for Research retrieves cost and usage
    /// data starting
    /// at `2017-01-01` up to the end date. The start date must be equal to or no
    /// later
    /// than the current date to avoid a validation error.
    start: ?i64,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
