/// Data for agent discovery.
pub const DiscoveryData = struct {
    /// List of capabilities to associate with agent.
    capability_arns: []const []const u8,

    /// List of private IP addresses to associate with agent.
    private_ip_addresses: []const []const u8,

    /// List of public IP addresses to associate with agent.
    public_ip_addresses: []const []const u8,

    pub const json_field_names = .{
        .capability_arns = "capabilityArns",
        .private_ip_addresses = "privateIpAddresses",
        .public_ip_addresses = "publicIpAddresses",
    };
};
