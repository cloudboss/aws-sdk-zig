/// Information about a subnet mapping.
pub const SubnetMapping = struct {
    /// [Network Load Balancers] The allocation ID of the Elastic IP address for an
    /// internet-facing load balancer.
    allocation_id: ?[]const u8 = null,

    /// [Network Load Balancers] The IPv6 address.
    i_pv_6_address: ?[]const u8 = null,

    /// [Network Load Balancers] The private IPv4 address for an internal load
    /// balancer.
    private_i_pv_4_address: ?[]const u8 = null,

    /// [Network Load Balancers with UDP listeners] The IPv6 prefix to use for
    /// source NAT.
    /// Specify an IPv6 prefix (/80 netmask) from the subnet CIDR block or
    /// `auto_assigned`
    /// to use an IPv6 prefix selected at random from the subnet CIDR block.
    source_nat_ipv_6_prefix: ?[]const u8 = null,

    /// The ID of the subnet.
    subnet_id: ?[]const u8 = null,
};
