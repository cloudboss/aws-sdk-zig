const OriginAccessControlSummary = @import("origin_access_control_summary.zig").OriginAccessControlSummary;

/// A list of CloudFront origin access controls.
pub const OriginAccessControlList = struct {
    /// If there are more items in the list than are in this response, this value is
    /// `true`.
    is_truncated: bool,

    /// Contains the origin access controls in the list.
    items: ?[]const OriginAccessControlSummary = null,

    /// The value of the `Marker` field that was provided in the request.
    marker: []const u8,

    /// The maximum number of origin access controls requested.
    max_items: i32,

    /// If there are more items in the list than are in this response, this element
    /// is present. It contains the value to use in the `Marker` field of another
    /// request to continue listing origin access controls.
    next_marker: ?[]const u8 = null,

    /// The number of origin access controls returned in the response.
    quantity: i32,
};
