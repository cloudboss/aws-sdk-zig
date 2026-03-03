const MemoryDbReservedInstancesConfiguration = @import("memory_db_reserved_instances_configuration.zig").MemoryDbReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The MemoryDB reserved instances recommendation details.
///
/// While the API reference uses "MemoryDB reserved instances", the user guide
/// and other documentation refer to them as "MemoryDB reserved nodes", as the
/// terms are used interchangeably.
pub const MemoryDbReservedInstances = struct {
    /// The MemoryDB reserved instances configuration used for recommendations.
    configuration: ?MemoryDbReservedInstancesConfiguration = null,

    cost_calculation: ?ReservedInstancesCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
