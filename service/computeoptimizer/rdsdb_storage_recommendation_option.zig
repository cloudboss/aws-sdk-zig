const RDSEstimatedMonthlyVolumeIOPsCostVariation = @import("rds_estimated_monthly_volume_io_ps_cost_variation.zig").RDSEstimatedMonthlyVolumeIOPsCostVariation;
const SavingsOpportunity = @import("savings_opportunity.zig").SavingsOpportunity;
const RDSStorageSavingsOpportunityAfterDiscounts = @import("rds_storage_savings_opportunity_after_discounts.zig").RDSStorageSavingsOpportunityAfterDiscounts;
const DBStorageConfiguration = @import("db_storage_configuration.zig").DBStorageConfiguration;

/// Describes the recommendation options for DB storage.
pub const RDSDBStorageRecommendationOption = struct {
    /// The projected level of variation in monthly I/O costs for the DB storage
    /// recommendation option.
    estimated_monthly_volume_io_ps_cost_variation: ?RDSEstimatedMonthlyVolumeIOPsCostVariation = null,

    /// The rank identifier of the DB storage recommendation option.
    rank: i32 = 0,

    savings_opportunity: ?SavingsOpportunity = null,

    /// Describes the savings opportunity for DB storage recommendations or for the
    /// recommendation option.
    ///
    /// Savings opportunity represents the estimated monthly savings after applying
    /// Savings Plans discounts. You can achieve
    /// this by implementing a given Compute Optimizer recommendation.
    savings_opportunity_after_discounts: ?RDSStorageSavingsOpportunityAfterDiscounts = null,

    /// The recommended storage configuration.
    storage_configuration: ?DBStorageConfiguration = null,

    pub const json_field_names = .{
        .estimated_monthly_volume_io_ps_cost_variation = "estimatedMonthlyVolumeIOPsCostVariation",
        .rank = "rank",
        .savings_opportunity = "savingsOpportunity",
        .savings_opportunity_after_discounts = "savingsOpportunityAfterDiscounts",
        .storage_configuration = "storageConfiguration",
    };
};
