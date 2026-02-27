/// The configuration for time-shifted viewing.
pub const TimeShiftConfiguration = struct {
    /// The maximum time delay for time-shifted viewing. The minimum allowed maximum
    /// time delay is 0 seconds, and the maximum allowed maximum time delay is 21600
    /// seconds (6 hours).
    max_time_delay_seconds: i32,

    pub const json_field_names = .{
        .max_time_delay_seconds = "MaxTimeDelaySeconds",
    };
};
