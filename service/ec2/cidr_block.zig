/// Describes an IPv4 CIDR block.
pub const CidrBlock = struct {
    /// The IPv4 CIDR block.
    cidr_block: ?[]const u8,
};
