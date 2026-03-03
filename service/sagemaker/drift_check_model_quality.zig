const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Represents the drift check model quality baselines that can be used when the
/// model monitor is set using the model package.
pub const DriftCheckModelQuality = struct {
    /// The drift check model quality constraints.
    constraints: ?MetricsSource = null,

    /// The drift check model quality statistics.
    statistics: ?MetricsSource = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .statistics = "Statistics",
    };
};
