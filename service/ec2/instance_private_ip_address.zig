const InstanceNetworkInterfaceAssociation = @import("instance_network_interface_association.zig").InstanceNetworkInterfaceAssociation;

/// Describes a private IPv4 address.
pub const InstancePrivateIpAddress = struct {
    /// The association information for an Elastic IP address for the network
    /// interface.
    association: ?InstanceNetworkInterfaceAssociation,

    /// Indicates whether this IPv4 address is the primary private IP address of the
    /// network
    /// interface.
    primary: ?bool,

    /// The private IPv4 DNS name.
    private_dns_name: ?[]const u8,

    /// The private IPv4 address of the network interface.
    private_ip_address: ?[]const u8,
};
