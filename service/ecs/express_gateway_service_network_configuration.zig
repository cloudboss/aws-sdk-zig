/// The network configuration for an Express service. By default, an Express
/// service utilizes subnets and security groups associated with the default
/// VPC.
pub const ExpressGatewayServiceNetworkConfiguration = struct {
    /// The IDs of the security groups associated with the Express service.
    security_groups: ?[]const []const u8,

    /// The IDs of the subnets associated with the Express service.
    subnets: ?[]const []const u8,

    pub const json_field_names = .{
        .security_groups = "securityGroups",
        .subnets = "subnets",
    };
};
