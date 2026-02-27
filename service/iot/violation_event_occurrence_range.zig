/// Specifies the time period of which violation events occurred between.
pub const ViolationEventOccurrenceRange = struct {
    /// The end date and time of a time period in which violation events occurred.
    end_time: i64,

    /// The start date and time of a time period in which violation events occurred.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
