/// Represents a time interval for a bill or estimate.
pub const BillInterval = struct {
    /// The end date and time of the interval.
    end: ?i64 = null,

    /// The start date and time of the interval.
    start: ?i64 = null,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
