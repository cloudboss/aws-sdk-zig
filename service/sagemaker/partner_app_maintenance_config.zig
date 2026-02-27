/// Maintenance configuration settings for the SageMaker Partner AI App.
pub const PartnerAppMaintenanceConfig = struct {
    /// The day and time of the week in Coordinated Universal Time (UTC) 24-hour
    /// standard time that weekly maintenance updates are scheduled. This value must
    /// take the following format: `3-letter-day:24-h-hour:minute`. For example:
    /// `TUE:03:30`.
    maintenance_window_start: ?[]const u8,

    pub const json_field_names = .{
        .maintenance_window_start = "MaintenanceWindowStart",
    };
};
