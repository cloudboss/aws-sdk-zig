const EbsVolumeConfiguration = @import("ebs_volume_configuration.zig").EbsVolumeConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// Describes the Amazon Elastic Block Store volume configuration of the current
/// and recommended resource configuration for a recommendation.
pub const EbsVolume = struct {
    /// The Amazon Elastic Block Store volume configuration used for
    /// recommendations.
    configuration: ?EbsVolumeConfiguration = null,

    /// Cost impact of the recommendation.
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
