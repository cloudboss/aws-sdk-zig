const NetworkInterfaceAssociation = @import("network_interface_association.zig").NetworkInterfaceAssociation;

/// Describes the private IPv4 address of a network interface.
pub const NetworkInterfacePrivateIpAddress = struct {
    /// The association information for an Elastic IP address (IPv4) associated with
    /// the
    /// network interface.
    association: ?NetworkInterfaceAssociation = null,

    /// Indicates whether this IPv4 address is the primary private IPv4 address of
    /// the network
    /// interface.
    primary: ?bool = null,

    /// The private DNS name.
    private_dns_name: ?[]const u8 = null,

    /// The private IPv4 address.
    private_ip_address: ?[]const u8 = null,
};
