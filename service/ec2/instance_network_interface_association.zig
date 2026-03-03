/// Describes association information for an Elastic IP address (IPv4).
pub const InstanceNetworkInterfaceAssociation = struct {
    /// The carrier IP address associated with the network interface.
    carrier_ip: ?[]const u8 = null,

    /// The customer-owned IP address associated with the network interface.
    customer_owned_ip: ?[]const u8 = null,

    /// The ID of the owner of the Elastic IP address.
    ip_owner_id: ?[]const u8 = null,

    /// The public DNS name.
    public_dns_name: ?[]const u8 = null,

    /// The public IP address or Elastic IP address bound to the network interface.
    public_ip: ?[]const u8 = null,
};
