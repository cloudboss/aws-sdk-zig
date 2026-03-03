const AwsVpcConfiguration = @import("aws_vpc_configuration.zig").AwsVpcConfiguration;

/// The network configuration for a task or service.
pub const NetworkConfiguration = struct {
    /// The VPC subnets and security groups that are associated with a task.
    ///
    /// All specified subnets and security groups must be from the same VPC.
    awsvpc_configuration: ?AwsVpcConfiguration = null,

    pub const json_field_names = .{
        .awsvpc_configuration = "awsvpcConfiguration",
    };
};
