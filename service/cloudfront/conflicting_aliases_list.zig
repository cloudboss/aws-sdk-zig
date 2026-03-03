const ConflictingAlias = @import("conflicting_alias.zig").ConflictingAlias;

/// A list of aliases (also called CNAMEs) and the CloudFront standard
/// distributions and Amazon Web Services accounts that they are associated
/// with. In the list, the standard distribution and account IDs are partially
/// hidden, which allows you to identify the standard distributions and accounts
/// that you own, but helps to protect the information of ones that you don't
/// own.
pub const ConflictingAliasesList = struct {
    /// Contains the conflicting aliases in the list.
    items: ?[]const ConflictingAlias = null,

    /// The maximum number of conflicting aliases requested.
    max_items: ?i32 = null,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing conflicting aliases where you
    /// left off.
    next_marker: ?[]const u8 = null,

    /// The number of conflicting aliases returned in the response.
    quantity: ?i32 = null,
};
