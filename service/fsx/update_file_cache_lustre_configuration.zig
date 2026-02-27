/// The configuration update for an Amazon File Cache resource.
pub const UpdateFileCacheLustreConfiguration = struct {
    weekly_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .weekly_maintenance_start_time = "WeeklyMaintenanceStartTime",
    };
};
