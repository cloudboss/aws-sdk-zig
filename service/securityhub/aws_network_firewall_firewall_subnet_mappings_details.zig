/// A public subnet that Network Firewall uses for the firewall.
pub const AwsNetworkFirewallFirewallSubnetMappingsDetails = struct {
    /// The identifier of the subnet
    subnet_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_id = "SubnetId",
    };
};
