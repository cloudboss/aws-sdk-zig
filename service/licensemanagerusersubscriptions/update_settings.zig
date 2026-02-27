/// Updates the registered identity provider’s product related configuration
/// settings such as the subnets to provision VPC endpoints.
pub const UpdateSettings = struct {
    /// The ID of one or more subnets in which License Manager will create a VPC
    /// endpoint for products that require connectivity to activation servers.
    add_subnets: []const []const u8,

    /// The ID of one or more subnets to remove.
    remove_subnets: []const []const u8,

    /// A security group ID that allows inbound TCP port 1688 communication between
    /// resources in your VPC and the VPC endpoints for activation servers.
    security_group_id: ?[]const u8,

    pub const json_field_names = .{
        .add_subnets = "AddSubnets",
        .remove_subnets = "RemoveSubnets",
        .security_group_id = "SecurityGroupId",
    };
};
