/// The VPC Lattice configuration for your service that holds the information
/// for the
/// target group(s) Amazon ECS tasks will be registered to.
pub const VpcLatticeConfiguration = struct {
    /// The name of the port mapping to register in the VPC Lattice target group.
    /// This is the
    /// name of the `portMapping` you defined in your task definition.
    port_name: []const u8,

    /// The ARN of the IAM role to associate with this VPC Lattice configuration.
    /// This is the
    /// Amazon ECS  infrastructure IAM role that is used to manage your VPC Lattice
    /// infrastructure.
    role_arn: []const u8,

    /// The full Amazon Resource Name (ARN) of the target group or groups associated
    /// with the
    /// VPC Lattice configuration that the Amazon ECS tasks will be registered to.
    target_group_arn: []const u8,

    pub const json_field_names = .{
        .port_name = "portName",
        .role_arn = "roleArn",
        .target_group_arn = "targetGroupArn",
    };
};
