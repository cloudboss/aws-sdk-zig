const DistributionIdOwner = @import("distribution_id_owner.zig").DistributionIdOwner;

/// The list of distribution IDs and the Amazon Web Services accounts that they
/// belong to.
pub const DistributionIdOwnerList = struct {
    /// A flag that indicates whether more `DistributionIdOwner` objects remain to
    /// be listed. If your results were truncated, you can make a follow-up
    /// pagination request using the `Marker` request parameter to retrieve more
    /// results in the list.
    is_truncated: bool,

    /// The number of `DistributionIdOwner` objects.
    items: ?[]const DistributionIdOwner,

    /// Use this field when paginating results to indicate where to begin in your
    /// list of `DistributionIdOwner` objects. The response includes distributions
    /// in the list that occur after the marker. To get the next page of the list,
    /// set this field's value to the value of `NextMarker` from the current page's
    /// response.
    marker: []const u8,

    /// The maximum number of `DistributionIdOwner` objects to return.
    max_items: i32,

    /// A token used for pagination of results returned in the response. You can use
    /// the token from the previous request to define where the current request
    /// should begin.
    next_marker: ?[]const u8,

    /// Specifies the actual number of `DistributionIdOwner` objects included in the
    /// list for the current page.
    quantity: i32,
};
