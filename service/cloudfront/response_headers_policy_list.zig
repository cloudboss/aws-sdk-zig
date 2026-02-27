const ResponseHeadersPolicySummary = @import("response_headers_policy_summary.zig").ResponseHeadersPolicySummary;

/// A list of response headers policies.
pub const ResponseHeadersPolicyList = struct {
    /// The response headers policies in the list.
    items: ?[]const ResponseHeadersPolicySummary,

    /// The maximum number of response headers policies requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing response headers policies where
    /// you left off.
    next_marker: ?[]const u8,

    /// The number of response headers policies returned.
    quantity: i32,
};
