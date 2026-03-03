const EcsServiceConfiguration = @import("ecs_service_configuration.zig").EcsServiceConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The ECS service recommendation details.
pub const EcsService = struct {
    /// The ECS service configuration used for recommendations.
    configuration: ?EcsServiceConfiguration = null,

    /// Cost impact of the recommendation.
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
