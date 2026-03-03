const AggregatedLogOddsMetric = @import("aggregated_log_odds_metric.zig").AggregatedLogOddsMetric;

/// The details of the relative importance of the aggregated variables.
///
/// Account Takeover Insights (ATI) model uses event variables from the login
/// data you
/// provide to continuously calculate a set of variables (aggregated variables)
/// based on historical events. For example, your ATI model might calculate the
/// number of times an user has logged in using the same IP address.
/// In this case, event variables used to derive the aggregated variables are
/// `IP address` and `user`.
pub const AggregatedVariablesImportanceMetrics = struct {
    /// List of variables' metrics.
    log_odds_metrics: ?[]const AggregatedLogOddsMetric = null,

    pub const json_field_names = .{
        .log_odds_metrics = "logOddsMetrics",
    };
};
