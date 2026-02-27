const NatGatewayConfiguration = @import("nat_gateway_configuration.zig").NatGatewayConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The NAT Gateway recommendation details.
pub const NatGateway = struct {
    /// The NAT Gateway configuration used for recommendations.
    configuration: ?NatGatewayConfiguration,

    cost_calculation: ?ResourceCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
