const KeyGroupSummary = @import("key_group_summary.zig").KeyGroupSummary;

/// A list of key groups.
pub const KeyGroupList = struct {
    /// A list of key groups.
    items: ?[]const KeyGroupSummary = null,

    /// The maximum number of key groups requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing key groups.
    next_marker: ?[]const u8 = null,

    /// The number of key groups returned in the response.
    quantity: i32,
};
