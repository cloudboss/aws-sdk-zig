/// The VPC object you use to create or update a workforce.
pub const WorkforceVpcConfigRequest = struct {
    /// The VPC security group IDs, in the form `sg-xxxxxxxx`. The security groups
    /// must be for the same VPC as specified in the subnet.
    security_group_ids: ?[]const []const u8,

    /// The ID of the subnets in the VPC that you want to connect.
    subnets: ?[]const []const u8,

    /// The ID of the VPC that the workforce uses for communication.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnets = "Subnets",
        .vpc_id = "VpcId",
    };
};
