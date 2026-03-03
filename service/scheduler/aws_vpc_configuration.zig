const AssignPublicIp = @import("assign_public_ip.zig").AssignPublicIp;

/// This structure specifies the VPC subnets and security groups for the task,
/// and whether a public IP address is to be used. This structure is relevant
/// only for ECS tasks that use the awsvpc network mode.
pub const AwsVpcConfiguration = struct {
    /// Specifies whether the task's elastic network interface receives a public IP
    /// address. You can specify `ENABLED` only when `LaunchType` in `EcsParameters`
    /// is set to `FARGATE`.
    assign_public_ip: ?AssignPublicIp = null,

    /// Specifies the security groups associated with the task. These security
    /// groups must all be in the same VPC. You can specify as many as five security
    /// groups.
    /// If you do not specify a security group, the default security group for the
    /// VPC is used.
    security_groups: ?[]const []const u8 = null,

    /// Specifies the subnets associated with the task. These subnets must all be in
    /// the same VPC. You can specify as many as 16 subnets.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .assign_public_ip = "AssignPublicIp",
        .security_groups = "SecurityGroups",
        .subnets = "Subnets",
    };
};
