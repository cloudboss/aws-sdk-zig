/// Configuration for selecting source metrics for centralization.
pub const SourceMetricsConfiguration = struct {
    /// The filter expression that selects which source metrics to centralize.
    /// Currently, only `*` (all metrics) is supported. Other values return a
    /// validation error.
    metrics_selection_criteria: ?[]const u8 = null,

    pub const json_field_names = .{
        .metrics_selection_criteria = "MetricsSelectionCriteria",
    };
};
