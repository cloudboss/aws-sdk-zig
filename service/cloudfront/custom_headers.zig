const OriginCustomHeader = @import("origin_custom_header.zig").OriginCustomHeader;

/// A complex type that contains the list of Custom Headers for each origin.
pub const CustomHeaders = struct {
    /// **Optional**: A list that contains one `OriginCustomHeader` element for each
    /// custom header that you want CloudFront to forward to the origin. If Quantity
    /// is `0`, omit `Items`.
    items: ?[]const OriginCustomHeader = null,

    /// The number of custom headers, if any, for this distribution.
    quantity: i32,
};
