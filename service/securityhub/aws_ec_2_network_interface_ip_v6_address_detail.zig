/// Provides information about an IPV6 address that is associated with the
/// network
/// interface.
pub const AwsEc2NetworkInterfaceIpV6AddressDetail = struct {
    /// The IPV6 address.
    ip_v6_address: ?[]const u8,

    pub const json_field_names = .{
        .ip_v6_address = "IpV6Address",
    };
};
