const InstanceTypeConfig = @import("instance_type_config.zig").InstanceTypeConfig;
const InstanceFleetResizingSpecifications = @import("instance_fleet_resizing_specifications.zig").InstanceFleetResizingSpecifications;

/// Configuration parameters for an instance fleet modification request.
///
/// The instance fleet configuration is available only in Amazon EMR releases
/// 4.8.0 and later, excluding 5.0.x versions.
pub const InstanceFleetModifyConfig = struct {
    /// Reserved.
    context: ?[]const u8 = null,

    /// A unique identifier for the instance fleet.
    instance_fleet_id: []const u8,

    /// An array of InstanceTypeConfig objects that specify how Amazon EMR
    /// provisions Amazon EC2 instances
    /// when it fulfills On-Demand and Spot capacities. For more information, see
    /// [InstanceTypeConfig](https://docs.aws.amazon.com/emr/latest/APIReference/API_InstanceTypeConfig.html).
    instance_type_configs: ?[]const InstanceTypeConfig = null,

    /// The resize specification for the instance fleet.
    resize_specifications: ?InstanceFleetResizingSpecifications = null,

    /// The target capacity of On-Demand units for the instance fleet. For more
    /// information see
    /// InstanceFleetConfig$TargetOnDemandCapacity.
    target_on_demand_capacity: ?i32 = null,

    /// The target capacity of Spot units for the instance fleet. For more
    /// information, see
    /// InstanceFleetConfig$TargetSpotCapacity.
    target_spot_capacity: ?i32 = null,

    pub const json_field_names = .{
        .context = "Context",
        .instance_fleet_id = "InstanceFleetId",
        .instance_type_configs = "InstanceTypeConfigs",
        .resize_specifications = "ResizeSpecifications",
        .target_on_demand_capacity = "TargetOnDemandCapacity",
        .target_spot_capacity = "TargetSpotCapacity",
    };
};
