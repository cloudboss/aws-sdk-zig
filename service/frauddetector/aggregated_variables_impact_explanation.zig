/// The details of the impact of aggregated variables on the prediction score.
///
/// Account Takeover Insights (ATI) model uses the login data you
/// provide to continuously calculate a set of variables (aggregated variables)
/// based on historical events. For example, the model might calculate the
/// number of times an user has logged in using the same IP address.
/// In this case, event variables used to derive the aggregated variables are
/// `IP address` and `user`.
pub const AggregatedVariablesImpactExplanation = struct {
    /// The names of all the event variables that were used to derive the aggregated
    /// variables.
    event_variable_names: ?[]const []const u8,

    /// The raw, uninterpreted value represented as log-odds of the fraud. These
    /// values are usually between -10 to +10, but range from -infinity to
    /// +infinity.
    ///
    /// * A positive value indicates that the variables drove the risk score up.
    ///
    /// * A negative value indicates that the variables drove the risk score down.
    log_odds_impact: ?f32,

    /// The relative impact of the aggregated variables in terms of magnitude on the
    /// prediction scores.
    relative_impact: ?[]const u8,

    pub const json_field_names = .{
        .event_variable_names = "eventVariableNames",
        .log_odds_impact = "logOddsImpact",
        .relative_impact = "relativeImpact",
    };
};
