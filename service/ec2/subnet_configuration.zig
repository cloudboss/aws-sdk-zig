/// Describes the configuration of a subnet for a VPC endpoint.
pub const SubnetConfiguration = struct {
    /// The IPv4 address to assign to the endpoint network interface in the subnet.
    /// You must provide
    /// an IPv4 address if the VPC endpoint supports IPv4.
    ///
    /// If you specify an IPv4 address when modifying a VPC endpoint, we replace the
    /// existing
    /// endpoint network interface with a new endpoint network interface with this
    /// IP address.
    /// This process temporarily disconnects the subnet and the VPC endpoint.
    ipv_4: ?[]const u8,

    /// The IPv6 address to assign to the endpoint network interface in the subnet.
    /// You must provide
    /// an IPv6 address if the VPC endpoint supports IPv6.
    ///
    /// If you specify an IPv6 address when modifying a VPC endpoint, we replace the
    /// existing
    /// endpoint network interface with a new endpoint network interface with this
    /// IP address.
    /// This process temporarily disconnects the subnet and the VPC endpoint.
    ipv_6: ?[]const u8,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,
};
