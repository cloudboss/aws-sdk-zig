/// A VpcConfig object that specifies the VPC that you want your workforce to
/// connect to.
pub const WorkforceVpcConfigResponse = struct {
    /// The VPC security group IDs, in the form sg-xxxxxxxx. The security groups
    /// must be for the same VPC as specified in the subnet.
    security_group_ids: []const []const u8,

    /// The ID of the subnets in the VPC that you want to connect.
    subnets: []const []const u8,

    /// The IDs for the VPC service endpoints of your VPC workforce when it is
    /// created and updated.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of the VPC that the workforce uses for communication.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
    };
};
