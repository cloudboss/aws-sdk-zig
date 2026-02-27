/// Provides configuration information needed to connect to an Amazon VPC
/// (Virtual Private Cloud).
pub const DataSourceVpcConfiguration = struct {
    /// A list of identifiers of security groups within your Amazon VPC. The
    /// security groups should enable Amazon Q Business to connect to the data
    /// source.
    security_group_ids: []const []const u8,

    /// A list of identifiers for subnets within your Amazon VPC. The subnets should
    /// be able to connect to each other in the VPC, and they should have outgoing
    /// access to the Internet through a NAT device.
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
