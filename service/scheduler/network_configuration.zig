const AwsVpcConfiguration = @import("aws_vpc_configuration.zig").AwsVpcConfiguration;

/// Specifies the network configuration for an ECS task.
pub const NetworkConfiguration = struct {
    /// Specifies the Amazon VPC subnets and security groups for the task, and
    /// whether a public IP address is to be used. This structure is relevant only
    /// for ECS tasks that use the awsvpc network mode.
    awsvpc_configuration: ?AwsVpcConfiguration = null,

    pub const json_field_names = .{
        .awsvpc_configuration = "awsvpcConfiguration",
    };
};
