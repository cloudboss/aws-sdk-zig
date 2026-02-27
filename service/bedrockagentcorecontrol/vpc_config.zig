/// VpcConfig for the Agent.
pub const VpcConfig = struct {
    /// The security groups associated with the VPC configuration.
    security_groups: []const []const u8,

    /// The subnets associated with the VPC configuration.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
