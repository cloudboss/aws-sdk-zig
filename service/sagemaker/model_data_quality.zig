const MetricsSource = @import("metrics_source.zig").MetricsSource;

/// Data quality constraints and statistics for a model.
pub const ModelDataQuality = struct {
    /// Data quality constraints for a model.
    constraints: ?MetricsSource = null,

    /// Data quality statistics for a model.
    statistics: ?MetricsSource = null,

    pub const json_field_names = .{
        .constraints = "Constraints",
        .statistics = "Statistics",
    };
};
