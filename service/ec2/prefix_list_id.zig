/// Describes a prefix list ID.
pub const PrefixListId = struct {
    /// A description for the security group rule that references this prefix list
    /// ID.
    ///
    /// Constraints: Up to 255 characters in length. Allowed characters are a-z,
    /// A-Z, 0-9,
    /// spaces, and ._-:/()#,@[]+=;{}!$*
    description: ?[]const u8 = null,

    /// The ID of the prefix.
    prefix_list_id: ?[]const u8 = null,
};
