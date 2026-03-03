const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Represents the drift check data quality baselines that can be used when the
/// model monitor is set using the model package.
pub const DriftCheckModelDataQuality = struct {
    /// The drift check model data quality constraints.
    constraints: ?MetricsSource = null,

    /// The drift check model data quality statistics.
    statistics: ?MetricsSource = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .statistics = "Statistics",
    };
};
