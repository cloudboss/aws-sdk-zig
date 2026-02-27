/// The security groups that allow traffic between the Amazon EVS control plane
/// and your VPC for Amazon EVS service access. If a security group is not
/// specified, Amazon EVS uses the default security group in your account for
/// service access.
pub const ServiceAccessSecurityGroups = struct {
    /// The security groups that allow service access.
    security_groups: ?[]const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
    };
};
