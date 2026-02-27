/// Contains other private IP address information of the EC2 instance.
pub const PrivateIpAddressDetails = struct {
    /// The private DNS name of the EC2 instance.
    private_dns_name: ?[]const u8,

    /// The private IP address of the EC2 instance.
    private_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .private_dns_name = "PrivateDnsName",
        .private_ip_address = "PrivateIpAddress",
    };
};
