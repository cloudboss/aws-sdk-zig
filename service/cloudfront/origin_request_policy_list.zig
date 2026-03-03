const OriginRequestPolicySummary = @import("origin_request_policy_summary.zig").OriginRequestPolicySummary;

/// A list of origin request policies.
pub const OriginRequestPolicyList = struct {
    /// Contains the origin request policies in the list.
    items: ?[]const OriginRequestPolicySummary = null,

    /// The maximum number of origin request policies requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value that you should use in the `Marker` field
    /// of a subsequent request to continue listing origin request policies where
    /// you left off.
    next_marker: ?[]const u8 = null,

    /// The total number of origin request policies returned in the response.
    quantity: i32,
};
