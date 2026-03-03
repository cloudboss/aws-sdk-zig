const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Model quality statistics and constraints.
pub const ModelQuality = struct {
    /// Model quality constraints.
    constraints: ?MetricsSource = null,

    /// Model quality statistics.
    statistics: ?MetricsSource = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .statistics = "Statistics",
    };
};
