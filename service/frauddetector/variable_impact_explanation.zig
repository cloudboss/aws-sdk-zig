/// The details of the event variable's impact on the prediction score.
pub const VariableImpactExplanation = struct {
    /// The event variable name.
    event_variable_name: ?[]const u8,

    /// The raw, uninterpreted value represented as log-odds of the fraud. These
    /// values are usually between -10 to +10, but range from - infinity to +
    /// infinity.
    ///
    /// * A positive value indicates that the variable drove the risk score up.
    ///
    /// * A negative value indicates that the variable drove the risk score down.
    log_odds_impact: ?f32,

    /// The event variable's relative impact in terms of magnitude on the prediction
    /// scores.
    /// The relative impact values consist of a numerical rating (0-5, 5 being the
    /// highest) and direction (increased/decreased) impact of the fraud risk.
    relative_impact: ?[]const u8,

    pub const json_field_names = .{
        .event_variable_name = "eventVariableName",
        .log_odds_impact = "logOddsImpact",
        .relative_impact = "relativeImpact",
    };
};
