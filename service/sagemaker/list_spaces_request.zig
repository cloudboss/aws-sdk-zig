const SpaceSortKey = @import("space_sort_key.zig").SpaceSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;

pub const ListSpacesRequest = struct {
    /// A parameter to search for the domain ID.
    domain_id_equals: ?[]const u8 = null,

    /// This parameter defines the maximum number of results that can be return in a
    /// single response. The `MaxResults` parameter is an upper bound, not a target.
    /// If there are more results available than the value specified, a `NextToken`
    /// is provided in the response. The `NextToken` indicates that the user should
    /// get the next set of results by providing this token as a part of a
    /// subsequent call. The default value for `MaxResults` is 10.
    max_results: ?i32 = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is `CreationTime`.
    sort_by: ?SpaceSortKey = null,

    /// The sort order for the results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    /// A parameter by which to filter the results.
    space_name_contains: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id_equals = "DomainIdEquals",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .space_name_contains = "SpaceNameContains",
    };
};
