const InstanceFleetType = @import("instance_fleet_type.zig").InstanceFleetType;
const InstanceTypeConfig = @import("instance_type_config.zig").InstanceTypeConfig;
const InstanceFleetProvisioningSpecifications = @import("instance_fleet_provisioning_specifications.zig").InstanceFleetProvisioningSpecifications;
const InstanceFleetResizingSpecifications = @import("instance_fleet_resizing_specifications.zig").InstanceFleetResizingSpecifications;

/// The configuration that defines an instance fleet.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleetConfig = struct {
    /// Reserved.
    context: ?[]const u8 = null,

    /// The node type that the instance fleet hosts. Valid values are MASTER, CORE,
    /// and
    /// TASK.
    instance_fleet_type: InstanceFleetType,

    /// The instance type configurations that define the Amazon EC2 instances in the
    /// instance fleet.
    instance_type_configs: ?[]const InstanceTypeConfig = null,

    /// The launch specification for the instance fleet.
    launch_specifications: ?InstanceFleetProvisioningSpecifications = null,

    /// The friendly name of the instance fleet.
    name: ?[]const u8 = null,

    /// The resize specification for the instance fleet.
    resize_specifications: ?InstanceFleetResizingSpecifications = null,

    /// The target capacity of On-Demand units for the instance fleet, which
    /// determines how many
    /// On-Demand Instances to provision. When the instance fleet launches, Amazon
    /// EMR
    /// tries to provision On-Demand Instances as specified by InstanceTypeConfig.
    /// Each instance configuration has a specified `WeightedCapacity`. When an
    /// On-Demand Instance is provisioned, the `WeightedCapacity` units count toward
    /// the
    /// target capacity. Amazon EMR provisions instances until the target capacity
    /// is
    /// totally fulfilled, even if this results in an overage. For example, if there
    /// are 2 units
    /// remaining to fulfill capacity, and Amazon EMR can only provision an instance
    /// with a
    /// `WeightedCapacity` of 5 units, the instance is provisioned, and the target
    /// capacity is exceeded by 3 units.
    ///
    /// If not specified or set to 0, only Spot Instances are provisioned for the
    /// instance
    /// fleet using `TargetSpotCapacity`. At least one of
    /// `TargetSpotCapacity` and `TargetOnDemandCapacity` should be
    /// greater than 0. For a master instance fleet, only one of
    /// `TargetSpotCapacity`
    /// and `TargetOnDemandCapacity` can be specified, and its value must be
    /// 1.
    target_on_demand_capacity: ?i32 = null,

    /// The target capacity of Spot units for the instance fleet, which determines
    /// how many Spot
    /// Instances to provision. When the instance fleet launches, Amazon EMR tries
    /// to
    /// provision Spot Instances as specified by InstanceTypeConfig. Each
    /// instance configuration has a specified `WeightedCapacity`. When a Spot
    /// Instance
    /// is provisioned, the `WeightedCapacity` units count toward the target
    /// capacity.
    /// Amazon EMR provisions instances until the target capacity is totally
    /// fulfilled,
    /// even if this results in an overage. For example, if there are 2 units
    /// remaining to fulfill
    /// capacity, and Amazon EMR can only provision an instance with a
    /// `WeightedCapacity` of 5 units, the instance is provisioned, and the target
    /// capacity is exceeded by 3 units.
    ///
    /// If not specified or set to 0, only On-Demand Instances are provisioned for
    /// the
    /// instance fleet. At least one of `TargetSpotCapacity` and
    /// `TargetOnDemandCapacity` should be greater than 0. For a master instance
    /// fleet, only one of `TargetSpotCapacity` and
    /// `TargetOnDemandCapacity` can be specified, and its value must be 1.
    target_spot_capacity: ?i32 = null,

    pub const json_field_names = .{
        .context = "Context",
        .instance_fleet_type = "InstanceFleetType",
        .instance_type_configs = "InstanceTypeConfigs",
        .launch_specifications = "LaunchSpecifications",
        .name = "Name",
        .resize_specifications = "ResizeSpecifications",
        .target_on_demand_capacity = "TargetOnDemandCapacity",
        .target_spot_capacity = "TargetSpotCapacity",
    };
};
