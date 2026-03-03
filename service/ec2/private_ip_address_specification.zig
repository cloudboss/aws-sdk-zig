/// Describes a secondary private IPv4 address for a network interface.
pub const PrivateIpAddressSpecification = struct {
    /// Indicates whether the private IPv4 address is the primary private IPv4
    /// address. Only
    /// one IPv4 address can be designated as primary.
    primary: ?bool = null,

    /// The private IPv4 address.
    private_ip_address: ?[]const u8 = null,
};
