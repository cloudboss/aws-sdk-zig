const InvalidationSummary = @import("invalidation_summary.zig").InvalidationSummary;

/// The `InvalidationList` complex type describes the list of invalidation
/// objects. For more information about invalidation, see [Invalidating Objects
/// (Web Distributions
/// Only)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html) in the *Amazon CloudFront Developer Guide*.
pub const InvalidationList = struct {
    /// A flag that indicates whether more invalidation batch requests remain to be
    /// listed. If your results were truncated, you can make a follow-up pagination
    /// request using the `Marker` request parameter to retrieve more invalidation
    /// batches in the list.
    is_truncated: bool,

    /// A complex type that contains one `InvalidationSummary` element for each
    /// invalidation batch created by the current Amazon Web Services account.
    items: ?[]const InvalidationSummary = null,

    /// The value that you provided for the `Marker` request parameter.
    marker: []const u8,

    /// The value that you provided for the `MaxItems` request parameter.
    max_items: i32,

    /// If `IsTruncated` is `true`, this element is present and contains the value
    /// that you can use for the `Marker` request parameter to continue listing your
    /// invalidation batches where they left off.
    next_marker: ?[]const u8 = null,

    /// The number of invalidation batches that were created by the current Amazon
    /// Web Services account.
    quantity: i32,
};
