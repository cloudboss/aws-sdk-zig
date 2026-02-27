/// Details about a provisional configuration.
pub const ProvisionalConfiguration = struct {
    /// Maximum time for the provisional configuration, in minutes.
    max_time_to_live_in_minutes: i32,

    pub const json_field_names = .{
        .max_time_to_live_in_minutes = "MaxTimeToLiveInMinutes",
    };
};
