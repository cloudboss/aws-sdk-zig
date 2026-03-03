/// Information about an IPAM policy allocation rule.
///
/// Allocation rules are optional configurations within an IPAM policy that map
/// Amazon Web Services resource types to specific IPAM pools. If no rules are
/// defined, the resource types default to using Amazon-provided IP addresses.
pub const IpamPolicyAllocationRule = struct {
    /// The ID of the source IPAM pool for the allocation rule.
    ///
    /// An IPAM pool is a collection of IP addresses in IPAM that can be allocated
    /// to Amazon Web Services resources.
    source_ipam_pool_id: ?[]const u8 = null,
};
