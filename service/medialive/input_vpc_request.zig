/// Settings for a private VPC Input.
/// When this property is specified, the input destination addresses will be
/// created in a VPC rather than with public Internet addresses.
/// This property requires setting the roleArn property on Input creation.
/// Not compatible with the inputSecurityGroups property.
pub const InputVpcRequest = struct {
    /// A list of up to 5 EC2 VPC security group IDs to attach to the Input VPC
    /// network interfaces.
    /// Requires subnetIds. If none are specified then the VPC default security
    /// group will be used.
    security_group_ids: ?[]const []const u8,

    /// A list of 2 VPC subnet IDs from the same VPC.
    /// Subnet IDs must be mapped to two unique availability zones (AZ).
    subnet_ids: []const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
