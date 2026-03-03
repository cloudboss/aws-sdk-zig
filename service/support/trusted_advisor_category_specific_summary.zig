const TrustedAdvisorCostOptimizingSummary = @import("trusted_advisor_cost_optimizing_summary.zig").TrustedAdvisorCostOptimizingSummary;

/// The container for summary information that relates to the category of the
/// Trusted Advisor
/// check.
pub const TrustedAdvisorCategorySpecificSummary = struct {
    /// The summary information about cost savings for a Trusted Advisor check that
    /// is in the Cost
    /// Optimizing category.
    cost_optimizing: ?TrustedAdvisorCostOptimizingSummary = null,

    pub const json_field_names = .{
        .cost_optimizing = "costOptimizing",
    };
};
