/// Interval of the driver work-rest schedule. Stops are added to fulfil the
/// provided rest schedule.
pub const RouteDriverScheduleInterval = struct {
    /// Maximum allowed driving time before stopping to rest.
    ///
    /// **Unit**: `seconds`
    drive_duration: i64 = 0,

    /// Resting time before the driver can continue driving.
    ///
    /// **Unit**: `seconds`
    rest_duration: i64 = 0,

    pub const json_field_names = .{
        .drive_duration = "DriveDuration",
        .rest_duration = "RestDuration",
    };
};
