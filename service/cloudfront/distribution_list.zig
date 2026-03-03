const DistributionSummary = @import("distribution_summary.zig").DistributionSummary;

/// A distribution list.
pub const DistributionList = struct {
    /// A flag that indicates whether more distributions remain to be listed. If
    /// your results were truncated, you can make a follow-up pagination request
    /// using the `Marker` request parameter to retrieve more distributions in the
    /// list.
    is_truncated: bool,

    /// A complex type that contains one `DistributionSummary` element for each
    /// distribution that was created by the current Amazon Web Services account.
    items: ?[]const DistributionSummary = null,

    /// The value you provided for the `Marker` request parameter.
    marker: []const u8,

    /// The value you provided for the `MaxItems` request parameter.
    max_items: i32,

    /// If `IsTruncated` is `true`, this element is present and contains the value
    /// you can use for the `Marker` request parameter to continue listing your
    /// distributions where they left off.
    next_marker: ?[]const u8 = null,

    /// The number of distributions that were created by the current Amazon Web
    /// Services account.
    quantity: i32,
};
