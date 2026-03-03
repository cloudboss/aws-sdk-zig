/// A list of distribution IDs.
pub const DistributionIdList = struct {
    /// A flag that indicates whether more distribution IDs remain to be listed. If
    /// your results were truncated, you can make a subsequent request using the
    /// `Marker` request field to retrieve more distribution IDs in the list.
    is_truncated: bool,

    /// Contains the distribution IDs in the list.
    items: ?[]const []const u8 = null,

    /// The value provided in the `Marker` request field.
    marker: []const u8,

    /// The maximum number of distribution IDs requested.
    max_items: i32,

    /// Contains the value that you should use in the `Marker` field of a subsequent
    /// request to continue listing distribution IDs where you left off.
    next_marker: ?[]const u8 = null,

    /// The total number of distribution IDs returned in the response.
    quantity: i32,
};
