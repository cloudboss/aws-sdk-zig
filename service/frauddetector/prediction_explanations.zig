const AggregatedVariablesImpactExplanation = @import("aggregated_variables_impact_explanation.zig").AggregatedVariablesImpactExplanation;
const VariableImpactExplanation = @import("variable_impact_explanation.zig").VariableImpactExplanation;

/// The prediction explanations that provide insight into how each event
/// variable impacted the model version's fraud prediction score.
pub const PredictionExplanations = struct {
    /// The details of the aggregated variables impact on the prediction score.
    ///
    /// Account Takeover Insights (ATI) model uses event variables from the login
    /// data you
    /// provide to continuously calculate a set of variables (aggregated variables)
    /// based on historical events. For example, your ATI model might calculate the
    /// number of times an user has logged in using the same IP address.
    /// In this case, event variables used to derive the aggregated variables are
    /// `IP address` and `user`.
    aggregated_variables_impact_explanations: ?[]const AggregatedVariablesImpactExplanation,

    /// The details of the event variable's impact on the prediction score.
    variable_impact_explanations: ?[]const VariableImpactExplanation,

    pub const json_field_names = .{
        .aggregated_variables_impact_explanations = "aggregatedVariablesImpactExplanations",
        .variable_impact_explanations = "variableImpactExplanations",
    };
};
