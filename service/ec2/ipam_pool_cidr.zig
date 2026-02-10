const IpamPoolCidrFailureReason = @import("ipam_pool_cidr_failure_reason.zig").IpamPoolCidrFailureReason;
const IpamPoolCidrState = @import("ipam_pool_cidr_state.zig").IpamPoolCidrState;

/// A CIDR provisioned to an IPAM pool.
pub const IpamPoolCidr = struct {
    /// The CIDR provisioned to the IPAM pool. A CIDR is a representation of an IP
    /// address and its associated network mask (or netmask)
    /// and refers to a range of IP addresses. An IPv4 CIDR example is
    /// `10.24.34.0/23`. An IPv6 CIDR example is `2001:DB8::/32`.
    cidr: ?[]const u8,

    /// Details related to why an IPAM pool CIDR failed to be provisioned.
    failure_reason: ?IpamPoolCidrFailureReason,

    /// The IPAM pool CIDR ID.
    ipam_pool_cidr_id: ?[]const u8,

    /// The netmask length of the CIDR you'd like to provision to a pool. Can be
    /// used for provisioning Amazon-provided IPv6 CIDRs to top-level pools and for
    /// provisioning CIDRs to pools with source pools. Cannot be used to provision
    /// BYOIP CIDRs to top-level pools. "NetmaskLength" or "Cidr" is required.
    netmask_length: ?i32,

    /// The state of the CIDR.
    state: ?IpamPoolCidrState,
};
