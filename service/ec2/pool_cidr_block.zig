/// Describes a CIDR block for an address pool.
pub const PoolCidrBlock = struct {
    /// The CIDR block.
    cidr: ?[]const u8,
};
