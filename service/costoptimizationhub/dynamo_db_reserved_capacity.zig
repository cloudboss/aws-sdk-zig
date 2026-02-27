const DynamoDbReservedCapacityConfiguration = @import("dynamo_db_reserved_capacity_configuration.zig").DynamoDbReservedCapacityConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The DynamoDB reserved capacity recommendation details.
pub const DynamoDbReservedCapacity = struct {
    /// The DynamoDB reserved capacity configuration used for recommendations.
    configuration: ?DynamoDbReservedCapacityConfiguration,

    cost_calculation: ?ReservedInstancesCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
