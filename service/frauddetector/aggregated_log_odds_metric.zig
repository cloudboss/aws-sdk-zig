/// The log odds metric details.
///
/// Account Takeover Insights (ATI) model uses event variables from the login
/// data you
/// provide to continuously calculate a set of variables (aggregated variables)
/// based on historical events. For example, your ATI model might calculate the
/// number of times an user has logged in using the same IP address.
/// In this case, event variables used to derive the aggregated variables are
/// `IP address` and `user`.
pub const AggregatedLogOddsMetric = struct {
    /// The relative importance of the variables in the list to the other event
    /// variable.
    aggregated_variables_importance: f32,

    /// The names of all the variables.
    variable_names: []const []const u8,

    pub const json_field_names = .{
        .aggregated_variables_importance = "aggregatedVariablesImportance",
        .variable_names = "variableNames",
    };
};
