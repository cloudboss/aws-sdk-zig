/// Defines a time range for spending limits, specifying when the limit is
/// active.
pub const TimePeriod = struct {
    /// The end date and time for the spending limit period, in epoch seconds.
    end_at: i64,

    /// The start date and time for the spending limit period, in epoch seconds.
    start_at: i64,

    pub const json_field_names = .{
        .end_at = "endAt",
        .start_at = "startAt",
    };
};
