/// An IPAM pool is a collection of IP address CIDRs.
/// IPAM pools enable you to organize your IP addresses
/// according to your routing and security needs.
pub const IpamPools = struct {
    /// The ID of the IPv4 IPAM pool.
    ipv_4_ipam_pool_id: ?[]const u8 = null,
};
