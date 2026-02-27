const AuroraDbClusterStorageConfiguration = @import("aurora_db_cluster_storage_configuration.zig").AuroraDbClusterStorageConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// Contains the details of an Aurora DB cluster storage.
pub const AuroraDbClusterStorage = struct {
    /// The Aurora DB cluster storage configuration used for recommendations.
    configuration: ?AuroraDbClusterStorageConfiguration,

    cost_calculation: ?ResourceCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
