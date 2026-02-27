/// The time period of the request.
pub const DateInterval = struct {
    /// The end of the time period. The end date is exclusive. For example, if
    /// `end` is `2017-05-01`, Amazon Web Services retrieves cost and
    /// usage data from the start date up to, but not including, `2017-05-01`.
    end: []const u8,

    /// The beginning of the time period. The start date is inclusive. For example,
    /// if
    /// `start` is `2017-01-01`, Amazon Web Services retrieves cost and
    /// usage data starting at `2017-01-01` up to the end date. The start date must
    /// be equal to or no later than the current date to avoid a validation error.
    start: []const u8,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
