/// A network settings resource that can be associated with a web portal. Once
/// associated with a web portal, network settings define how streaming
/// instances will connect with your specified VPC.
pub const NetworkSettings = struct {
    /// A list of web portal ARNs that this network settings is associated with.
    associated_portal_arns: ?[]const []const u8 = null,

    /// The ARN of the network settings.
    network_settings_arn: []const u8,

    /// One or more security groups used to control access from streaming instances
    /// to your VPC.
    security_group_ids: ?[]const []const u8 = null,

    /// The subnets in which network interfaces are created to connect streaming
    /// instances to your VPC. At least two of these subnets must be in different
    /// availability zones.
    subnet_ids: ?[]const []const u8 = null,

    /// The VPC that streaming instances will connect to.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_portal_arns = "associatedPortalArns",
        .network_settings_arn = "networkSettingsArn",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
