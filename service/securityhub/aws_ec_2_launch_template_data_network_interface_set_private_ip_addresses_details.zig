/// One or more private IPv4 addresses.
pub const AwsEc2LaunchTemplateDataNetworkInterfaceSetPrivateIpAddressesDetails = struct {
    /// Indicates whether the private IPv4 address is the primary private IPv4
    /// address. Only one IPv4 address can be designated as primary.
    primary: ?bool,

    /// The private IPv4 address.
    private_ip_address: ?[]const u8,

    pub const json_field_names = .{
        .primary = "Primary",
        .private_ip_address = "PrivateIpAddress",
    };
};
