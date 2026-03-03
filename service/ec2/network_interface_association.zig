/// Describes association information for an Elastic IP address (IPv4 only), or
/// a Carrier
/// IP address (for a network interface which resides in a subnet in a
/// Wavelength
/// Zone).
pub const NetworkInterfaceAssociation = struct {
    /// The allocation ID.
    allocation_id: ?[]const u8 = null,

    /// The association ID.
    association_id: ?[]const u8 = null,

    /// The carrier IP address associated with the network interface.
    ///
    /// This option is only available when the network interface is in a subnet
    /// which is
    /// associated with a Wavelength Zone.
    carrier_ip: ?[]const u8 = null,

    /// The customer-owned IP address associated with the network interface.
    customer_owned_ip: ?[]const u8 = null,

    /// The ID of the Elastic IP address owner.
    ip_owner_id: ?[]const u8 = null,

    /// The public DNS name.
    public_dns_name: ?[]const u8 = null,

    /// The address of the Elastic IP address bound to the network interface.
    public_ip: ?[]const u8 = null,
};
