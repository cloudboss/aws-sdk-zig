/// Specifies an IPv6 address in an Amazon EC2 launch template.
pub const AwsEc2LaunchTemplateDataNetworkInterfaceSetIpv6AddressesDetails = struct {
    /// One or more specific IPv6 addresses from the IPv6 CIDR block range of your
    /// subnet.
    ipv_6_address: ?[]const u8,

    pub const json_field_names = .{
        .ipv_6_address = "Ipv6Address",
    };
};
