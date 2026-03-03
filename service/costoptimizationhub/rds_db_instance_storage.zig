const RdsDbInstanceStorageConfiguration = @import("rds_db_instance_storage_configuration.zig").RdsDbInstanceStorageConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// Contains the details of an Amazon RDS DB instance storage.
pub const RdsDbInstanceStorage = struct {
    /// The Amazon RDS DB instance storage configuration used for recommendations.
    configuration: ?RdsDbInstanceStorageConfiguration = null,

    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
