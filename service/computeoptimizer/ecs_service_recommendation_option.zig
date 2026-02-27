const ContainerRecommendation = @import("container_recommendation.zig").ContainerRecommendation;
const ECSServiceProjectedUtilizationMetric = @import("ecs_service_projected_utilization_metric.zig").ECSServiceProjectedUtilizationMetric;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const ECSSavingsOpportunityAfterDiscounts = @import("ecs_savings_opportunity_after_discounts.zig").ECSSavingsOpportunityAfterDiscounts;

/// Describes the recommendation options for an Amazon ECS service.
pub const ECSServiceRecommendationOption = struct {
    /// The CPU and memory size recommendations for the containers within the task
    /// of your Amazon ECS service.
    container_recommendations: ?[]const ContainerRecommendation,

    /// The CPU size of the Amazon ECS service recommendation option.
    cpu: ?i32,

    /// The memory size of the Amazon ECS service recommendation option.
    memory: ?i32,

    /// An array of objects that describe the projected utilization metrics of the
    /// Amazon ECS service recommendation option.
    projected_utilization_metrics: ?[]const ECSServiceProjectedUtilizationMetric,

    savings_opportunity: ?SavingsOpportunity,

    /// Describes the savings opportunity for Amazon ECS service recommendations or
    /// for the recommendation option.
    ///
    /// Savings opportunity represents the estimated monthly savings after applying
    /// Savings Plans discounts.
    /// You can achieve this by implementing a given Compute Optimizer
    /// recommendation.
    savings_opportunity_after_discounts: ?ECSSavingsOpportunityAfterDiscounts,

    pub const json_field_names = .{
        .container_recommendations = "containerRecommendations",
        .cpu = "cpu",
        .memory = "memory",
        .projected_utilization_metrics = "projectedUtilizationMetrics",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
