/// The information about the maintenance schedule.
pub const MaintenanceSchedule = struct {
    /// The time the scheduled maintenance is to end.
    end_time: ?i64,

    /// The time the scheduled maintenance is to start.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
