const RDSDBUtilizationMetric = @import("rdsdb_utilization_metric.zig").RDSDBUtilizationMetric;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const RDSInstanceSavingsOpportunityAfterDiscounts = @import("rds_instance_savings_opportunity_after_discounts.zig").RDSInstanceSavingsOpportunityAfterDiscounts;

/// Describes the recommendation options for a DB instance.
pub const RDSDBInstanceRecommendationOption = struct {
    /// Describes the DB instance class recommendation option for your Amazon Aurora
    /// or RDS database.
    db_instance_class: ?[]const u8,

    /// The performance risk of the DB instance recommendation option.
    performance_risk: f64 = 0,

    /// An array of objects that describe the projected utilization metrics of the
    /// DB instance recommendation option.
    projected_utilization_metrics: ?[]const RDSDBUtilizationMetric,

    /// The rank identifier of the DB instance recommendation option.
    rank: i32 = 0,

    savings_opportunity: ?SavingsOpportunity,

    /// Describes the savings opportunity for Amazon Aurora and RDS database
    /// recommendations or for the recommendation option.
    ///
    /// Savings opportunity represents the estimated monthly savings after applying
    /// Savings Plans discounts.
    /// You can achieve this by implementing a given Compute Optimizer
    /// recommendation.
    savings_opportunity_after_discounts: ?RDSInstanceSavingsOpportunityAfterDiscounts,

    pub const json_field_names = .{
        .db_instance_class = "dbInstanceClass",
        .performance_risk = "performanceRisk",
        .projected_utilization_metrics = "projectedUtilizationMetrics",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
