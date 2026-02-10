const PoolCidrBlock = @import("pool_cidr_block.zig").PoolCidrBlock;
const Tag = @import("tag.zig").Tag;

/// Describes an IPv6 address pool.
pub const Ipv6Pool = struct {
    /// The description for the address pool.
    description: ?[]const u8,

    /// The CIDR blocks for the address pool.
    pool_cidr_blocks: ?[]const PoolCidrBlock,

    /// The ID of the address pool.
    pool_id: ?[]const u8,

    /// Any tags for the address pool.
    tags: ?[]const Tag,
};
