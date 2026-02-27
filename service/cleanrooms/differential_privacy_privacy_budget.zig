const DifferentialPrivacyPrivacyBudgetAggregation = @import("differential_privacy_privacy_budget_aggregation.zig").DifferentialPrivacyPrivacyBudgetAggregation;

/// Specifies the configured epsilon value and the utility in terms of total
/// aggregations, as well as the remaining aggregations available.
pub const DifferentialPrivacyPrivacyBudget = struct {
    /// This information includes the configured epsilon value and the utility in
    /// terms of total aggregations, as well as the remaining aggregations.
    aggregations: []const DifferentialPrivacyPrivacyBudgetAggregation,

    /// The epsilon value that you configured.
    epsilon: i32,

    pub const json_field_names = .{
        .aggregations = "aggregations",
        .epsilon = "epsilon",
    };
};
