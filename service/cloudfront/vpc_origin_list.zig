const VpcOriginSummary = @import("vpc_origin_summary.zig").VpcOriginSummary;

/// A list of CloudFront VPC origins.
pub const VpcOriginList = struct {
    /// A flag that indicates whether more VPC origins remain to be listed. If your
    /// results were truncated, you can make a follow-up pagination request using
    /// the `Marker` request parameter to retrieve more VPC origins in the list.
    is_truncated: bool,

    /// The items of the VPC origins list.
    items: ?[]const VpcOriginSummary = null,

    /// The marker associated with the VPC origins list.
    marker: []const u8,

    /// The maximum number of items included in the list.
    max_items: i32,

    /// The next marker associated with the VPC origins list.
    next_marker: ?[]const u8 = null,

    /// The number of VPC origins in the list.
    quantity: i32,
};
