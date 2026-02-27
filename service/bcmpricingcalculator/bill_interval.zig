/// Represents a time interval for a bill or estimate.
pub const BillInterval = struct {
    /// The end date and time of the interval.
    end: ?i64,

    /// The start date and time of the interval.
    start: ?i64,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
