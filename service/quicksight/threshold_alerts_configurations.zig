/// The threshold alerts configuration for an embedded Quick Sight dashboard.
pub const ThresholdAlertsConfigurations = struct {
    /// The threshold alerts configuration for an embedded Quick Sight dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
