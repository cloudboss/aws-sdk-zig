/// Configures detailed monitoring for WorkSpace Instance.
pub const RunInstancesMonitoringEnabled = struct {
    /// Enables or disables detailed instance monitoring.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
