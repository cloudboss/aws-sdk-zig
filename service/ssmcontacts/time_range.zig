/// A range of between two set times
pub const TimeRange = struct {
    /// The end of the time range.
    end_time: ?i64,

    /// The start of the time range.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
