/// Describes a private IPv4 address specification for a secondary interface
/// request.
pub const SecondaryInterfacePrivateIpAddressSpecificationRequest = struct {
    /// The private IPv4 address.
    private_ip_address: ?[]const u8 = null,
};
