const GameServerContainerGroupCounts = @import("game_server_container_group_counts.zig").GameServerContainerGroupCounts;
const EC2InstanceCounts = @import("ec2_instance_counts.zig").EC2InstanceCounts;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;
const ManagedCapacityConfiguration = @import("managed_capacity_configuration.zig").ManagedCapacityConfiguration;

/// Current resource capacity settings for managed EC2 fleets and managed
/// container fleets. For
/// multi-location fleets, location values might refer to a fleet's remote
/// location or its
/// home Region.
///
/// **Returned by:**
/// [DescribeFleetCapacity](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetCapacity.html), [DescribeFleetLocationCapacity](https://docs.aws.amazon.com/gamelift/latest/apireference/API_DescribeFleetLocationCapacity.html), [UpdateFleetCapacity](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateFleetCapacity.html)
pub const FleetCapacity = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers fleet resource and uniquely
    /// identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::fleet/fleet-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    fleet_arn: ?[]const u8 = null,

    /// A unique identifier for the fleet associated with the location.
    fleet_id: ?[]const u8 = null,

    /// The number and status of game server container groups deployed in a
    /// container fleet.
    game_server_container_group_counts: ?GameServerContainerGroupCounts = null,

    /// The current number of instances in the fleet, listed by instance status.
    /// Counts for pending and
    /// terminating instances might be non-zero if the fleet is adjusting to a
    /// scaling event
    /// or if access to resources is temporarily affected.
    instance_counts: ?EC2InstanceCounts = null,

    /// The Amazon EC2 instance type that is used for instances in a fleet. Instance
    /// type
    /// determines the computing resources in use, including CPU, memory, storage,
    /// and
    /// networking capacity. See [Amazon Elastic Compute Cloud
    /// Instance Types](http://aws.amazon.com/ec2/instance-types/) for detailed
    /// descriptions.
    instance_type: ?EC2InstanceType = null,

    /// The fleet location for the instance count information, expressed as an
    /// Amazon Web Services Region
    /// code, such as `us-west-2`.
    location: ?[]const u8 = null,

    /// Configuration settings for managed capacity scaling.
    managed_capacity_configuration: ?ManagedCapacityConfiguration = null,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .game_server_container_group_counts = "GameServerContainerGroupCounts",
        .instance_counts = "InstanceCounts",
        .instance_type = "InstanceType",
        .location = "Location",
        .managed_capacity_configuration = "ManagedCapacityConfiguration",
    };
};
