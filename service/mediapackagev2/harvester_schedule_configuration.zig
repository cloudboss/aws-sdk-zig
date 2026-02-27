/// Defines the schedule configuration for a harvest job.
pub const HarvesterScheduleConfiguration = struct {
    /// The end time for the harvest job.
    end_time: i64,

    /// The start time for the harvest job.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
