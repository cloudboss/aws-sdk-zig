const PublicIpv4PoolRange = @import("public_ipv_4_pool_range.zig").PublicIpv4PoolRange;
const Tag = @import("tag.zig").Tag;

/// Describes an IPv4 address pool.
pub const PublicIpv4Pool = struct {
    /// A description of the address pool.
    description: ?[]const u8 = null,

    /// The name of the location from which the address pool is advertised.
    /// A network border group is a unique set of Availability Zones or Local Zones
    /// from where Amazon Web Services advertises public IP addresses.
    network_border_group: ?[]const u8 = null,

    /// The address ranges.
    pool_address_ranges: ?[]const PublicIpv4PoolRange = null,

    /// The ID of the address pool.
    pool_id: ?[]const u8 = null,

    /// Any tags for the address pool.
    tags: ?[]const Tag = null,

    /// The total number of addresses.
    total_address_count: ?i32 = null,

    /// The total number of available addresses.
    total_available_address_count: ?i32 = null,
};
