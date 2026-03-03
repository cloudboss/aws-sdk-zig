const RdsDbInstanceConfiguration = @import("rds_db_instance_configuration.zig").RdsDbInstanceConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// Contains the details of an Amazon RDS DB instance.
pub const RdsDbInstance = struct {
    /// The Amazon RDS DB instance configuration used for recommendations.
    configuration: ?RdsDbInstanceConfiguration = null,

    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
