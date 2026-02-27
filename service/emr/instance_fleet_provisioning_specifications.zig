const OnDemandProvisioningSpecification = @import("on_demand_provisioning_specification.zig").OnDemandProvisioningSpecification;
const SpotProvisioningSpecification = @import("spot_provisioning_specification.zig").SpotProvisioningSpecification;

/// The launch specification for On-Demand and Spot Instances in the fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions. On-Demand and Spot instance
/// allocation
/// strategies are available in Amazon EMR releases 5.12.1 and later.
pub const InstanceFleetProvisioningSpecifications = struct {
    /// The launch specification for On-Demand Instances in the instance fleet,
    /// which
    /// determines the allocation strategy and capacity reservation options.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions. On-Demand Instances allocation
    /// strategy is
    /// available in Amazon EMR releases 5.12.1 and later.
    on_demand_specification: ?OnDemandProvisioningSpecification,

    /// The launch specification for Spot instances in the fleet, which determines
    /// the allocation strategy, defined
    /// duration, and provisioning timeout behavior.
    spot_specification: ?SpotProvisioningSpecification,

    pub const json_field_names = .{
        .on_demand_specification = "OnDemandSpecification",
        .spot_specification = "SpotSpecification",
    };
};
