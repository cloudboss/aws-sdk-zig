/// An entry for a prefix list.
pub const AddPrefixListEntry = struct {
    /// The CIDR block.
    cidr: []const u8,

    /// A description for the entry.
    ///
    /// Constraints: Up to 255 characters in length.
    description: ?[]const u8,
};
