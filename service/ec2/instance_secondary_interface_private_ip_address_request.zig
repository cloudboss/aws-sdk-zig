/// Describes a private IPv4 address for a secondary interface request.
pub const InstanceSecondaryInterfacePrivateIpAddressRequest = struct {
    /// The private IPv4 address.
    private_ip_address: []const u8,
};
