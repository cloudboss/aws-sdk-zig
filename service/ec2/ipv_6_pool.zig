const PoolCidrBlock = @import("pool_cidr_block.zig").PoolCidrBlock;
const Tag = @import("tag.zig").Tag;

/// Describes an IPv6 address pool.
pub const Ipv6Pool = struct {
    /// The description for the address pool.
    description: ?[]const u8 = null,

    /// The CIDR blocks for the address pool.
    pool_cidr_blocks: ?[]const PoolCidrBlock = null,

    /// The ID of the address pool.
    pool_id: ?[]const u8 = null,

    /// Any tags for the address pool.
    tags: ?[]const Tag = null,
};
