const IpamPoolAllocationResourceType = @import("ipam_pool_allocation_resource_type.zig").IpamPoolAllocationResourceType;

/// In IPAM, an allocation is a CIDR assignment from an IPAM pool to another
/// IPAM pool or to a resource.
pub const IpamPoolAllocation = struct {
    /// The CIDR for the allocation. A CIDR is a representation of an IP address and
    /// its associated network mask (or netmask) and
    /// refers to a range of IP addresses. An IPv4 CIDR example is `10.24.34.0/23`.
    /// An IPv6 CIDR example is `2001:DB8::/32`.
    cidr: ?[]const u8 = null,

    /// A description of the pool allocation.
    description: ?[]const u8 = null,

    /// The ID of an allocation.
    ipam_pool_allocation_id: ?[]const u8 = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The owner of the resource.
    resource_owner: ?[]const u8 = null,

    /// The Amazon Web Services Region of the resource.
    resource_region: ?[]const u8 = null,

    /// The type of the resource.
    resource_type: ?IpamPoolAllocationResourceType = null,
};
