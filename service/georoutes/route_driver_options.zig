const RouteDriverScheduleInterval = @import("route_driver_schedule_interval.zig").RouteDriverScheduleInterval;

/// Driver related options.
pub const RouteDriverOptions = struct {
    /// Driver work-rest schedule. Stops are added to fulfil the provided rest
    /// schedule.
    schedule: ?[]const RouteDriverScheduleInterval,

    pub const json_field_names = .{
        .schedule = "Schedule",
    };
};
