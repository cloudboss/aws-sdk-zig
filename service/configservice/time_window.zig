/// Filters evaluation results based on start and end times.
pub const TimeWindow = struct {
    /// The end time of an execution. The end time must be after the start date.
    end_time: ?i64,

    /// The start time of an execution.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
