const EbsVolume = @import("ebs_volume.zig").EbsVolume;
const MarketType = @import("market_type.zig").MarketType;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;

/// Represents an Amazon EC2 instance provisioned as part of cluster.
pub const Instance = struct {
    /// The list of Amazon EBS volumes that are attached to this instance.
    ebs_volumes: ?[]const EbsVolume = null,

    /// The unique identifier of the instance in Amazon EC2.
    ec_2_instance_id: ?[]const u8 = null,

    /// The unique identifier for the instance in Amazon EMR.
    id: ?[]const u8 = null,

    /// The unique identifier of the instance fleet to which an Amazon EC2 instance
    /// belongs.
    instance_fleet_id: ?[]const u8 = null,

    /// The identifier of the instance group to which this instance belongs.
    instance_group_id: ?[]const u8 = null,

    /// The Amazon EC2 instance type, for example `m3.xlarge`.
    instance_type: ?[]const u8 = null,

    /// The instance purchasing option. Valid values are `ON_DEMAND` or
    /// `SPOT`.
    market: ?MarketType = null,

    /// The private DNS name of the instance.
    private_dns_name: ?[]const u8 = null,

    /// The private IP address of the instance.
    private_ip_address: ?[]const u8 = null,

    /// The public DNS name of the instance.
    public_dns_name: ?[]const u8 = null,

    /// The public IP address of the instance.
    public_ip_address: ?[]const u8 = null,

    /// The current status of the instance.
    status: ?InstanceStatus = null,

    pub const json_field_names = .{
        .ebs_volumes = "EbsVolumes",
        .ec_2_instance_id = "Ec2InstanceId",
        .id = "Id",
        .instance_fleet_id = "InstanceFleetId",
        .instance_group_id = "InstanceGroupId",
        .instance_type = "InstanceType",
        .market = "Market",
        .private_dns_name = "PrivateDnsName",
        .private_ip_address = "PrivateIpAddress",
        .public_dns_name = "PublicDnsName",
        .public_ip_address = "PublicIpAddress",
        .status = "Status",
    };
};
