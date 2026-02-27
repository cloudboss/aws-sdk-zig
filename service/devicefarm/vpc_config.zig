/// Contains the VPC configuration data necessary to interface with AWS Device
/// Farm's services.
pub const VpcConfig = struct {
    /// An array of one or more security groups IDs in your Amazon VPC.
    security_group_ids: []const []const u8,

    /// An array of one or more subnet IDs in your Amazon VPC.
    subnet_ids: []const []const u8,

    /// The ID of the Amazon VPC.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
