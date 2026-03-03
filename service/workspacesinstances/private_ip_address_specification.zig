/// Defines private IP address configuration for network interface.
pub const PrivateIpAddressSpecification = struct {
    /// Indicates if this is the primary private IP address.
    primary: ?bool = null,

    /// Specific private IP address for the network interface.
    private_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .primary = "Primary",
        .private_ip_address = "PrivateIpAddress",
    };
};
