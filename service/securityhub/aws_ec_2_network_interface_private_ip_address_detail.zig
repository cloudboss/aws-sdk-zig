/// Provides information about a private IPv4 address that is with the network
/// interface.
pub const AwsEc2NetworkInterfacePrivateIpAddressDetail = struct {
    /// The private DNS name for the IP address.
    private_dns_name: ?[]const u8,

    /// The IP address.
    private_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .private_dns_name = "PrivateDnsName",
        .private_ip_address = "PrivateIpAddress",
    };
};
