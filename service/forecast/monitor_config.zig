/// The configuration details for the predictor monitor.
pub const MonitorConfig = struct {
    /// The name of the monitor resource.
    monitor_name: []const u8,

    pub const json_field_names = .{
        .monitor_name = "MonitorName",
    };
};
