/// Describes a prefix list entry.
pub const PrefixListEntry = struct {
    /// The CIDR block.
    cidr: ?[]const u8 = null,

    /// The description.
    description: ?[]const u8 = null,
};
