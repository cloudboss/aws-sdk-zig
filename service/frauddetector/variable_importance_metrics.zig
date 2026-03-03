const LogOddsMetric = @import("log_odds_metric.zig").LogOddsMetric;

/// The variable importance metrics details.
pub const VariableImportanceMetrics = struct {
    /// List of variable metrics.
    log_odds_metrics: ?[]const LogOddsMetric = null,

    pub const json_field_names = .{
        .log_odds_metrics = "logOddsMetrics",
    };
};
