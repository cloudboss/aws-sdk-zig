const InstanceFleetType = @import("instance_fleet_type.zig").InstanceFleetType;
const InstanceTypeSpecification = @import("instance_type_specification.zig").InstanceTypeSpecification;
const InstanceFleetProvisioningSpecifications = @import("instance_fleet_provisioning_specifications.zig").InstanceFleetProvisioningSpecifications;
const InstanceFleetResizingSpecifications = @import("instance_fleet_resizing_specifications.zig").InstanceFleetResizingSpecifications;
const InstanceFleetStatus = @import("instance_fleet_status.zig").InstanceFleetStatus;

/// Describes an instance fleet, which is a group of Amazon EC2 instances that
/// host
/// a particular node type (master, core, or task) in an Amazon EMR cluster.
/// Instance
/// fleets can consist of a mix of instance types and On-Demand and Spot
/// Instances, which are
/// provisioned to meet a defined target capacity.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleet = struct {
    /// Reserved.
    context: ?[]const u8,

    /// The unique identifier of the instance fleet.
    id: ?[]const u8,

    /// The node type that the instance fleet hosts. Valid values are MASTER, CORE,
    /// or TASK.
    instance_fleet_type: ?InstanceFleetType,

    /// An array of specifications for the instance types that comprise an instance
    /// fleet.
    instance_type_specifications: ?[]const InstanceTypeSpecification,

    /// Describes the launch specification for an instance fleet.
    launch_specifications: ?InstanceFleetProvisioningSpecifications,

    /// A friendly name for the instance fleet.
    name: ?[]const u8,

    /// The number of On-Demand units that have been provisioned for the instance
    /// fleet to
    /// fulfill `TargetOnDemandCapacity`. This provisioned capacity might be less
    /// than
    /// or greater than `TargetOnDemandCapacity`.
    provisioned_on_demand_capacity: ?i32,

    /// The number of Spot units that have been provisioned for this instance fleet
    /// to fulfill
    /// `TargetSpotCapacity`. This provisioned capacity might be less than or
    /// greater
    /// than `TargetSpotCapacity`.
    provisioned_spot_capacity: ?i32,

    /// The resize specification for the instance fleet.
    resize_specifications: ?InstanceFleetResizingSpecifications,

    /// The current status of the instance fleet.
    status: ?InstanceFleetStatus,

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
    /// capacity is exceeded by 3 units. You can use
    /// InstanceFleet$ProvisionedOnDemandCapacity to determine the Spot capacity
    /// units that have been provisioned for the instance fleet.
    ///
    /// If not specified or set to 0, only Spot Instances are provisioned for the
    /// instance
    /// fleet using `TargetSpotCapacity`. At least one of
    /// `TargetSpotCapacity` and `TargetOnDemandCapacity` should be
    /// greater than 0. For a master instance fleet, only one of
    /// `TargetSpotCapacity`
    /// and `TargetOnDemandCapacity` can be specified, and its value must be
    /// 1.
    target_on_demand_capacity: ?i32,

    /// The target capacity of Spot units for the instance fleet, which determines
    /// how many Spot
    /// Instances to provision. When the instance fleet launches, Amazon EMR tries
    /// to
    /// provision Spot Instances as specified by InstanceTypeConfig. Each
    /// instance configuration has a specified `WeightedCapacity`. When a Spot
    /// instance
    /// is provisioned, the `WeightedCapacity` units count toward the target
    /// capacity.
    /// Amazon EMR provisions instances until the target capacity is totally
    /// fulfilled,
    /// even if this results in an overage. For example, if there are 2 units
    /// remaining to fulfill
    /// capacity, and Amazon EMR can only provision an instance with a
    /// `WeightedCapacity` of 5 units, the instance is provisioned, and the target
    /// capacity is exceeded by 3 units. You can use
    /// InstanceFleet$ProvisionedSpotCapacity to determine the Spot capacity units
    /// that have been provisioned for the instance fleet.
    ///
    /// If not specified or set to 0, only On-Demand Instances are provisioned for
    /// the
    /// instance fleet. At least one of `TargetSpotCapacity` and
    /// `TargetOnDemandCapacity` should be greater than 0. For a master instance
    /// fleet, only one of `TargetSpotCapacity` and
    /// `TargetOnDemandCapacity` can be specified, and its value must be 1.
    target_spot_capacity: ?i32,

    pub const json_field_names = .{
        .context = "Context",
        .id = "Id",
        .instance_fleet_type = "InstanceFleetType",
        .instance_type_specifications = "InstanceTypeSpecifications",
        .launch_specifications = "LaunchSpecifications",
        .name = "Name",
        .provisioned_on_demand_capacity = "ProvisionedOnDemandCapacity",
        .provisioned_spot_capacity = "ProvisionedSpotCapacity",
        .resize_specifications = "ResizeSpecifications",
        .status = "Status",
        .target_on_demand_capacity = "TargetOnDemandCapacity",
        .target_spot_capacity = "TargetSpotCapacity",
    };
};
