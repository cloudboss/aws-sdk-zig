/// Information about a static IP address for a load balancer.
pub const LoadBalancerAddress = struct {
    /// [Network Load Balancers] The allocation ID of the Elastic IP address for an
    /// internal-facing load balancer.
    allocation_id: ?[]const u8 = null,

    /// The static IP address.
    ip_address: ?[]const u8 = null,

    /// [Network Load Balancers] The IPv6 address.
    i_pv_6_address: ?[]const u8 = null,

    /// [Network Load Balancers] The private IPv4 address for an internal load
    /// balancer.
    private_i_pv_4_address: ?[]const u8 = null,
};
