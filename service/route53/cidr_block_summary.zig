/// A complex type that lists the CIDR blocks.
pub const CidrBlockSummary = struct {
    /// Value for the CIDR block.
    cidr_block: ?[]const u8,

    /// The location name of the CIDR block.
    location_name: ?[]const u8,
};
