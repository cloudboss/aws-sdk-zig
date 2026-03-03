/// For tasks that use the `awsvpc` networking mode, the VPC subnet and security
/// group configuration.
pub const AwsEcsServiceNetworkConfigurationAwsVpcConfigurationDetails = struct {
    /// Whether the task's elastic network interface receives a public IP address.
    /// The default value is `DISABLED`.
    ///
    /// Valid values: `ENABLED` | `DISABLED`
    assign_public_ip: ?[]const u8 = null,

    /// The IDs of the security groups associated with the task or service.
    ///
    /// You can provide up to five security groups.
    security_groups: ?[]const []const u8 = null,

    /// The IDs of the subnets associated with the task or service.
    ///
    /// You can provide up to 16 subnets.
    subnets: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .assign_public_ip = "AssignPublicIp",
        .security_groups = "SecurityGroups",
        .subnets = "Subnets",
    };
};
