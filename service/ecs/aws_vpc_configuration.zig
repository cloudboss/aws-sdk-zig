const AssignPublicIp = @import("assign_public_ip.zig").AssignPublicIp;

/// An object representing the networking details for a task or service. For
/// example
/// `awsVpcConfiguration={subnets=["subnet-12344321"],securityGroups=["sg-12344321"]}`.
pub const AwsVpcConfiguration = struct {
    /// Whether the task's elastic network interface receives a public IP address.
    ///
    /// Consider the following when you set this value:
    ///
    /// * When you use `create-service` or `update-service`, the
    /// default is `DISABLED`.
    ///
    /// * When the service `deploymentController` is `ECS`, the
    /// value must be `DISABLED`.
    assign_public_ip: ?AssignPublicIp,

    /// The IDs of the security groups associated with the task or service. If you
    /// don't
    /// specify a security group, the default security group for the VPC is used.
    /// There's a
    /// limit of 5 security groups that can be specified.
    ///
    /// All specified security groups must be from the same VPC.
    security_groups: ?[]const []const u8,

    /// The IDs of the subnets associated with the task or service. There's a limit
    /// of 16
    /// subnets that can be specified.
    ///
    /// All specified subnets must be from the same VPC.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .assign_public_ip = "assignPublicIp",
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
