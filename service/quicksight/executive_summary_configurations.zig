/// The executive summary settings of an embedded Quick Sight console or
/// dashboard.
pub const ExecutiveSummaryConfigurations = struct {
    /// The executive summary settings of an embedded Quick Sight console or
    /// dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
