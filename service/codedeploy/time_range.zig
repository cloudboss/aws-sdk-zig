/// Information about a time range.
pub const TimeRange = struct {
    /// The end time of the time range.
    ///
    /// Specify null to leave the end time open-ended.
    end: ?i64,

    /// The start time of the time range.
    ///
    /// Specify null to leave the start time open-ended.
    start: ?i64,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
