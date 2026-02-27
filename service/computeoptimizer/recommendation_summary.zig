const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const CurrentPerformanceRiskRatings = @import("current_performance_risk_ratings.zig").CurrentPerformanceRiskRatings;
const IdleSummary = @import("idle_summary.zig").IdleSummary;
const InferredWorkloadSaving = @import("inferred_workload_saving.zig").InferredWorkloadSaving;
const RecommendationSourceType = @import("recommendation_source_type.zig").RecommendationSourceType;
const Summary = @import("summary.zig").Summary;

/// A summary of a recommendation.
pub const RecommendationSummary = struct {
    /// The Amazon Web Services account ID of the recommendation summary.
    account_id: ?[]const u8,

    aggregated_savings_opportunity: ?SavingsOpportunity,

    /// An object that describes the performance risk ratings for a given resource
    /// type.
    current_performance_risk_ratings: ?CurrentPerformanceRiskRatings,

    idle_savings_opportunity: ?SavingsOpportunity,

    /// Describes the findings summary of the idle resources.
    idle_summaries: ?[]const IdleSummary,

    /// An array of objects that describes the estimated monthly saving amounts for
    /// the instances running on the specified
    /// `inferredWorkloadTypes`. The array contains the top five savings
    /// opportunites for the instances that run
    /// inferred workload types.
    inferred_workload_savings: ?[]const InferredWorkloadSaving,

    /// The resource type that the recommendation summary applies to.
    recommendation_resource_type: ?RecommendationSourceType,

    /// An object that describes the savings opportunity for a given resource type.
    /// Savings
    /// opportunity includes the estimated monthly savings amount and percentage.
    savings_opportunity: ?SavingsOpportunity,

    /// An array of objects that describe a recommendation summary.
    summaries: ?[]const Summary,

    pub const json_field_names = .{
        .account_id = "accountId",
        .aggregated_savings_opportunity = "aggregatedSavingsOpportunity",
        .current_performance_risk_ratings = "currentPerformanceRiskRatings",
        .idle_savings_opportunity = "idleSavingsOpportunity",
        .idle_summaries = "idleSummaries",
        .inferred_workload_savings = "inferredWorkloadSavings",
        .recommendation_resource_type = "recommendationResourceType",
        .savings_opportunity = "savingsOpportunity",
        .summaries = "summaries",
    };
};
