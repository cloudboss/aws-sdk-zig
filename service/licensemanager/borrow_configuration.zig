/// Details about a borrow configuration.
pub const BorrowConfiguration = struct {
    /// Indicates whether early check-ins are allowed.
    allow_early_check_in: bool,

    /// Maximum time for the borrow configuration, in minutes.
    max_time_to_live_in_minutes: i32,

    pub const json_field_names = .{
        .allow_early_check_in = "AllowEarlyCheckIn",
        .max_time_to_live_in_minutes = "MaxTimeToLiveInMinutes",
    };
};
