const Filter = @import("filter.zig").Filter;

pub const DescribeTagsRequest = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool,

    /// The filters.
    ///
    /// * `key` - The tag key.
    ///
    /// * `resource-id` - The ID of the resource.
    ///
    /// * `resource-type` - The resource type. For a list of possible values, see
    /// [TagSpecification](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TagSpecification.html).
    ///
    /// * `tag`: - The key/value combination of the tag. For example,
    /// specify "tag:Owner" for the filter name and "TeamA" for the filter value to
    /// find
    /// resources with the tag "Owner=TeamA".
    ///
    /// * `value` - The tag value.
    filters: ?[]const Filter,

    /// The maximum number of items to return for this request. This value can be
    /// between 5 and 1000.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32,

    /// The token returned from a previous paginated request.
    /// Pagination continues from the end of the items returned by the previous
    /// request.
    next_token: ?[]const u8,
};
