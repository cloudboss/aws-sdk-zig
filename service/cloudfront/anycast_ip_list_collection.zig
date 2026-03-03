const AnycastIpListSummary = @import("anycast_ip_list_summary.zig").AnycastIpListSummary;

/// The Anycast static IP list collection.
pub const AnycastIpListCollection = struct {
    /// If there are more items in the list collection than are in this response,
    /// this value is `true`.
    is_truncated: bool,

    /// Items in the Anycast static IP list collection. Each item is of the
    /// AnycastIpListSummary structure type.
    items: ?[]const AnycastIpListSummary = null,

    /// Use this field when paginating results to indicate where to begin in your
    /// list. The response includes items in the list that occur after the marker.
    /// To get the next page of the list, set this field's value to the value of
    /// `NextMarker` from the current page's response.
    marker: []const u8,

    /// The maximum number of Anycast static IP list collections that you want
    /// returned in the response.
    max_items: i32,

    /// Indicates the next page of the Anycast static IP list collection. To get the
    /// next page of the list, use this value in the `Marker` field of your request.
    next_marker: ?[]const u8 = null,

    /// The quantity of Anycast static IP lists in the collection.
    quantity: i32,
};
