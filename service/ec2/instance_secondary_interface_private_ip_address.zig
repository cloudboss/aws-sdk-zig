/// Describes a private IPv4 address for a secondary interface.
pub const InstanceSecondaryInterfacePrivateIpAddress = struct {
    /// The private IPv4 address.
    private_ip_address: ?[]const u8 = null,
};
