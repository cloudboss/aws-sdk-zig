const VpcPeeringConnectionStatus = @import("vpc_peering_connection_status.zig").VpcPeeringConnectionStatus;

/// Represents a peering connection between a VPC on one of your Amazon Web
/// Services accounts and the
/// VPC for your Amazon GameLift Servers fleets. This record may be for an
/// active peering connection or a
/// pending connection that has not yet been established.
///
/// **Related actions**
///
/// [All APIs by
/// task](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-awssdk.html#reference-awssdk-resources-fleets)
pub const VpcPeeringConnection = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// associated with the GameLift fleet resource for this connection.
    fleet_arn: ?[]const u8,

    /// A unique identifier for the fleet. This ID determines the ID of the Amazon
    /// GameLift Servers VPC for your fleet.
    fleet_id: ?[]const u8,

    /// A unique identifier for the VPC that contains the Amazon GameLift Servers
    /// fleet for this connection.
    /// This VPC is managed by Amazon GameLift Servers and does not appear in your
    /// Amazon Web Services account.
    game_lift_vpc_id: ?[]const u8,

    /// CIDR block of IPv4 addresses assigned to the VPC peering connection for the
    /// GameLift
    /// VPC. The peered VPC also has an IPv4 CIDR block associated with it; these
    /// blocks cannot
    /// overlap or the peering connection cannot be created.
    ip_v4_cidr_block: ?[]const u8,

    /// A unique identifier for a VPC with resources to be accessed by your Amazon
    /// GameLift Servers fleet. The
    /// VPC must be in the same Region as your fleet. To look up a VPC ID, use the
    /// [VPC Dashboard](https://console.aws.amazon.com/vpc/) in the Amazon Web
    /// Services Management Console.
    /// Learn more about VPC peering in [VPC Peering with Amazon GameLift Servers
    /// Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).
    peer_vpc_id: ?[]const u8,

    /// The status information about the connection. Status indicates if a
    /// connection is
    /// pending, successful, or failed.
    status: ?VpcPeeringConnectionStatus,

    /// A unique identifier that is automatically assigned to the connection record.
    /// This ID
    /// is referenced in VPC peering connection events, and is used when deleting a
    /// connection.
    vpc_peering_connection_id: ?[]const u8,

    pub const json_field_names = .{
        .fleet_arn = "FleetArn",
        .fleet_id = "FleetId",
        .game_lift_vpc_id = "GameLiftVpcId",
        .ip_v4_cidr_block = "IpV4CidrBlock",
        .peer_vpc_id = "PeerVpcId",
        .status = "Status",
        .vpc_peering_connection_id = "VpcPeeringConnectionId",
    };
};
