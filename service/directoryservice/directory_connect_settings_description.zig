/// Contains information about an AD Connector directory.
pub const DirectoryConnectSettingsDescription = struct {
    /// The Availability Zones that the directory is in.
    availability_zones: ?[]const []const u8 = null,

    /// The IP addresses of the AD Connector servers.
    connect_ips: ?[]const []const u8 = null,

    /// The IPv6 addresses of the AD Connector servers.
    connect_ips_v6: ?[]const []const u8 = null,

    /// The user name of the service account in your self-managed directory.
    customer_user_name: ?[]const u8 = null,

    /// The security group identifier for the AD Connector directory.
    security_group_id: ?[]const u8 = null,

    /// A list of subnet identifiers in the VPC that the AD Connector is in.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC that the AD Connector is in.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .connect_ips = "ConnectIps",
        .connect_ips_v6 = "ConnectIpsV6",
        .customer_user_name = "CustomerUserName",
        .security_group_id = "SecurityGroupId",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
