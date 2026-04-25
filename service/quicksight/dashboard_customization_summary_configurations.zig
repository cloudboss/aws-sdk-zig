/// The dashboard customization summary configuration for an embedded Quick
/// Sight dashboard.
pub const DashboardCustomizationSummaryConfigurations = struct {
    /// The enabled status of the dashboard customization summary configuration for
    /// an embedded Quick Sight dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
