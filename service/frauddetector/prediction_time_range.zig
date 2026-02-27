/// The time period for when the predictions were generated.
pub const PredictionTimeRange = struct {
    /// The end time of the time period for when the predictions were generated.
    end_time: []const u8,

    /// The start time of the time period for when the predictions were generated.
    start_time: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
