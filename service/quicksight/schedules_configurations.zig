/// The schedules configuration for an embedded Quick Sight dashboard.
pub const SchedulesConfigurations = struct {
    /// The schedules configuration for an embedded Quick Sight dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
