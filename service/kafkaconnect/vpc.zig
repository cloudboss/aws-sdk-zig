/// Information about the VPC in which the connector resides.
pub const Vpc = struct {
    /// The security groups for the connector.
    security_groups: ?[]const []const u8,

    /// The subnets for the connector.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
