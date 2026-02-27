/// The time range of a cost estimation.
pub const CostEstimationTimeRange = struct {
    /// The end time of the cost estimation.
    end_time: ?i64,

    /// The start time of the cost estimation.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
