/// The configuration settings for a router network interface within a VPC,
/// including the security group IDs and subnet ID.
pub const VpcRouterNetworkInterfaceConfiguration = struct {
    /// The IDs of the security groups to associate with the router network
    /// interface within the VPC.
    security_group_ids: []const []const u8,

    /// The ID of the subnet within the VPC to associate the router network
    /// interface with.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_id = "SubnetId",
    };
};
