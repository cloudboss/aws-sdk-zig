const VolumeConfiguration = @import("volume_configuration.zig").VolumeConfiguration;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const EBSSavingsOpportunityAfterDiscounts = @import("ebs_savings_opportunity_after_discounts.zig").EBSSavingsOpportunityAfterDiscounts;

/// Describes a recommendation option for an Amazon Elastic Block Store (Amazon
/// EBS)
/// instance.
pub const VolumeRecommendationOption = struct {
    /// An array of objects that describe a volume configuration.
    configuration: ?VolumeConfiguration = null,

    /// The performance risk of the volume recommendation option.
    ///
    /// Performance risk is the likelihood of the recommended volume type meeting
    /// the
    /// performance requirement of your workload.
    ///
    /// The value ranges from `0` - `4`, with `0` meaning
    /// that the recommended resource is predicted to always provide enough hardware
    /// capability.
    /// The higher the performance risk is, the more likely you should validate
    /// whether the
    /// recommendation will meet the performance requirements of your workload
    /// before migrating
    /// your resource.
    performance_risk: f64 = 0,

    /// The rank of the volume recommendation option.
    ///
    /// The top recommendation option is ranked as `1`.
    rank: i32 = 0,

    /// An object that describes the savings opportunity for the EBS volume
    /// recommendation
    /// option. Savings opportunity includes the estimated monthly savings amount
    /// and
    /// percentage.
    savings_opportunity: ?SavingsOpportunity = null,

    /// An object that describes the savings opportunity for the Amazon EBS volume
    /// recommendation option with specific discounts. Savings
    /// opportunity includes the estimated monthly savings and percentage.
    savings_opportunity_after_discounts: ?EBSSavingsOpportunityAfterDiscounts = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .performance_risk = "performanceRisk",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
    };
};
