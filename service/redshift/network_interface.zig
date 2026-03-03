/// Describes a network interface.
pub const NetworkInterface = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The IPv6 address of the network interface within the subnet.
    ipv_6_address: ?[]const u8 = null,

    /// The network interface identifier.
    network_interface_id: ?[]const u8 = null,

    /// The IPv4 address of the network interface within the subnet.
    private_ip_address: ?[]const u8 = null,

    /// The subnet identifier.
    subnet_id: ?[]const u8 = null,
};
