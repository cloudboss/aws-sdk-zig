const CachePolicySummary = @import("cache_policy_summary.zig").CachePolicySummary;

/// A list of cache policies.
pub const CachePolicyList = struct {
    /// Contains the cache policies in the list.
    items: ?[]const CachePolicySummary,

    /// The maximum number of cache policies requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing cache policies where you left
    /// off.
    next_marker: ?[]const u8,

    /// The total number of cache policies returned in the response.
    quantity: i32,
};
