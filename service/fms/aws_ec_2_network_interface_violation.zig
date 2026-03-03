/// Violation detail for network interfaces associated with an EC2 instance.
pub const AwsEc2NetworkInterfaceViolation = struct {
    /// List of security groups that violate the rules specified in the primary
    /// security group of the Firewall Manager policy.
    violating_security_groups: ?[]const []const u8 = null,

    /// The resource ID of the network interface.
    violation_target: ?[]const u8 = null,

    pub const json_field_names = .{
        .violating_security_groups = "ViolatingSecurityGroups",
        .violation_target = "ViolationTarget",
    };
};
