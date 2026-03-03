const LambdaFunctionMemoryProjectedMetric = @import("lambda_function_memory_projected_metric.zig").LambdaFunctionMemoryProjectedMetric;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const LambdaSavingsOpportunityAfterDiscounts = @import("lambda_savings_opportunity_after_discounts.zig").LambdaSavingsOpportunityAfterDiscounts;

/// Describes a recommendation option for an Lambda function.
pub const LambdaFunctionMemoryRecommendationOption = struct {
    /// The memory size, in MB, of the function recommendation option.
    memory_size: i32 = 0,

    /// An array of objects that describe the projected utilization metrics of the
    /// function
    /// recommendation option.
    projected_utilization_metrics: ?[]const LambdaFunctionMemoryProjectedMetric = null,

    /// The rank of the function recommendation option.
    ///
    /// The top recommendation option is ranked as `1`.
    rank: i32 = 0,

    /// An object that describes the savings opportunity for the Lambda function
    /// recommendation option. Savings opportunity includes the estimated monthly
    /// savings amount
    /// and percentage.
    savings_opportunity: ?SavingsOpportunity = null,

    /// An object that describes the savings opportunity for the Lambda
    /// recommendation option which includes Saving Plans
    /// discounts. Savings opportunity includes the estimated monthly savings and
    /// percentage.
    savings_opportunity_after_discounts: ?LambdaSavingsOpportunityAfterDiscounts = null,

    pub const json_field_names = .{
        .memory_size = "memorySize",
        .projected_utilization_metrics = "projectedUtilizationMetrics",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
