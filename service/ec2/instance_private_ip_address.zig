const InstanceNetworkInterfaceAssociation = @import("instance_network_interface_association.zig").InstanceNetworkInterfaceAssociation;

/// Describes a private IPv4 address.
pub const InstancePrivateIpAddress = struct {
    /// The association information for an Elastic IP address for the network
    /// interface.
    association: ?InstanceNetworkInterfaceAssociation = null,

    /// Indicates whether this IPv4 address is the primary private IP address of the
    /// network
    /// interface.
    primary: ?bool = null,

    /// The private IPv4 DNS name.
    private_dns_name: ?[]const u8 = null,

    /// The private IPv4 address of the network interface.
    private_ip_address: ?[]const u8 = null,
};
