const CloudFrontOriginAccessIdentitySummary = @import("cloud_front_origin_access_identity_summary.zig").CloudFrontOriginAccessIdentitySummary;

/// Lists the origin access identities for CloudFront.Send a `GET` request to
/// the `/*CloudFront API version*/origin-access-identity/cloudfront` resource.
/// The response includes a `CloudFrontOriginAccessIdentityList` element with
/// zero or more `CloudFrontOriginAccessIdentitySummary` child elements. By
/// default, your entire list of origin access identities is returned in one
/// single page. If the list is long, you can paginate it using the `MaxItems`
/// and `Marker` parameters.
pub const CloudFrontOriginAccessIdentityList = struct {
    /// A flag that indicates whether more origin access identities remain to be
    /// listed. If your results were truncated, you can make a follow-up pagination
    /// request using the `Marker` request parameter to retrieve more items in the
    /// list.
    is_truncated: bool,

    /// A complex type that contains one `CloudFrontOriginAccessIdentitySummary`
    /// element for each origin access identity that was created by the current
    /// Amazon Web Services account.
    items: ?[]const CloudFrontOriginAccessIdentitySummary,

    /// Use this when paginating results to indicate where to begin in your list of
    /// origin access identities. The results include identities in the list that
    /// occur after the marker. To get the next page of results, set the `Marker` to
    /// the value of the `NextMarker` from the current page's response (which is
    /// also the ID of the last identity on that page).
    marker: []const u8,

    /// The maximum number of origin access identities you want in the response
    /// body.
    max_items: i32,

    /// If `IsTruncated` is `true`, this element is present and contains the value
    /// you can use for the `Marker` request parameter to continue listing your
    /// origin access identities where they left off.
    next_marker: ?[]const u8,

    /// The number of CloudFront origin access identities that were created by the
    /// current Amazon Web Services account.
    quantity: i32,
};
