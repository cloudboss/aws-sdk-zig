const IpamPoolSourceResourceType = @import("ipam_pool_source_resource_type.zig").IpamPoolSourceResourceType;

/// The resource used to provision CIDRs to a resource planning pool.
pub const IpamPoolSourceResourceRequest = struct {
    /// The source resource ID.
    resource_id: ?[]const u8 = null,

    /// The source resource owner.
    resource_owner: ?[]const u8 = null,

    /// The source resource Region.
    resource_region: ?[]const u8 = null,

    /// The source resource type.
    resource_type: ?IpamPoolSourceResourceType = null,
};
