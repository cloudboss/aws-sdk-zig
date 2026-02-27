/// Displays the next seven maintenance window occurrences and their start
/// times.
pub const ScheduledJobRollout = struct {
    /// Displays the start times of the next seven maintenance window occurrences.
    start_time: ?[]const u8,

    pub const json_field_names = .{
        .start_time = "startTime",
    };
};
