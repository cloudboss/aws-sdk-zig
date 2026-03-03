/// Contains information about a private IP address associated with a network
/// interface. This
/// data type is used as a response element in the DescribeFindings
/// action.
pub const PrivateIp = struct {
    /// The DNS name of the private IP address.
    private_dns_name: ?[]const u8 = null,

    /// The full IP address of the network inteface.
    private_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .private_dns_name = "privateDnsName",
        .private_ip_address = "privateIpAddress",
    };
};
