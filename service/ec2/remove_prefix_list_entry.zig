/// An entry for a prefix list.
pub const RemovePrefixListEntry = struct {
    /// The CIDR block.
    cidr: []const u8,
};
