const ComputeLimitsUnitType = @import("compute_limits_unit_type.zig").ComputeLimitsUnitType;

/// The Amazon EC2 unit limits for a managed scaling policy. The managed scaling
/// activity of a cluster can not be above or below these limits. The limit only
/// applies to the
/// core and task nodes. The master node cannot be scaled after initial
/// configuration.
pub const ComputeLimits = struct {
    /// The upper boundary of Amazon EC2 units. It is measured through vCPU cores or
    /// instances for instance groups and measured through units for instance
    /// fleets. Managed
    /// scaling activities are not allowed beyond this boundary. The limit only
    /// applies to the core
    /// and task nodes. The master node cannot be scaled after initial
    /// configuration.
    maximum_capacity_units: i32,

    /// The upper boundary of Amazon EC2 units for core node type in a cluster. It
    /// is
    /// measured through vCPU cores or instances for instance groups and measured
    /// through units for
    /// instance fleets. The core units are not allowed to scale beyond this
    /// boundary. The
    /// parameter is used to split capacity allocation between core and task nodes.
    maximum_core_capacity_units: ?i32 = null,

    /// The upper boundary of On-Demand Amazon EC2 units. It is measured through
    /// vCPU
    /// cores or instances for instance groups and measured through units for
    /// instance fleets. The
    /// On-Demand units are not allowed to scale beyond this boundary. The parameter
    /// is used to
    /// split capacity allocation between On-Demand and Spot Instances.
    maximum_on_demand_capacity_units: ?i32 = null,

    /// The lower boundary of Amazon EC2 units. It is measured through vCPU cores or
    /// instances for instance groups and measured through units for instance
    /// fleets. Managed
    /// scaling activities are not allowed beyond this boundary. The limit only
    /// applies to the core
    /// and task nodes. The master node cannot be scaled after initial
    /// configuration.
    minimum_capacity_units: i32,

    /// The unit type used for specifying a managed scaling policy.
    unit_type: ComputeLimitsUnitType,

    pub const json_field_names = .{
        .maximum_capacity_units = "MaximumCapacityUnits",
        .maximum_core_capacity_units = "MaximumCoreCapacityUnits",
        .maximum_on_demand_capacity_units = "MaximumOnDemandCapacityUnits",
        .minimum_capacity_units = "MinimumCapacityUnits",
        .unit_type = "UnitType",
    };
};
