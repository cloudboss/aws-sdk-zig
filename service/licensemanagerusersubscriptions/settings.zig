/// The registered identity provider’s product related configuration settings
/// such as the subnets to provision VPC endpoints, and the security group ID
/// that is associated with the VPC endpoints. The security group should permit
/// inbound TCP port 1688 communication from resources in the VPC.
pub const Settings = struct {
    /// A security group ID that allows inbound TCP port 1688 communication between
    /// resources in your VPC and the VPC endpoint for activation servers.
    security_group_id: []const u8,

    /// The subnets defined for the registered identity provider.
    subnets: []const []const u8,

    pub const json_field_names = .{
        .security_group_id = "SecurityGroupId",
        .subnets = "Subnets",
    };
};
