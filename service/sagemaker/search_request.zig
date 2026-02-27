const CrossAccountFilterOption = @import("cross_account_filter_option.zig").CrossAccountFilterOption;
const ResourceType = @import("resource_type.zig").ResourceType;
const SearchExpression = @import("search_expression.zig").SearchExpression;
const SearchSortOrder = @import("search_sort_order.zig").SearchSortOrder;
const VisibilityConditions = @import("visibility_conditions.zig").VisibilityConditions;

pub const SearchRequest = struct {
    /// A cross account filter option. When the value is `"CrossAccount"` the search
    /// results will only include resources made discoverable to you from other
    /// accounts. When the value is `"SameAccount"` or `null` the search results
    /// will only include resources from your account. Default is `null`. For more
    /// information on searching for resources made discoverable to your account,
    /// see [ Search discoverable
    /// resources](https://docs.aws.amazon.com/sagemaker/latest/dg/feature-store-cross-account-discoverability-use.html) in the SageMaker Developer Guide. The maximum number of `ResourceCatalog`s viewable is 1000.
    cross_account_filter_option: ?CrossAccountFilterOption,

    /// The maximum number of results to return.
    max_results: ?i32,

    /// If more than `MaxResults` resources match the specified `SearchExpression`,
    /// the response includes a `NextToken`. The `NextToken` can be passed to the
    /// next `SearchRequest` to continue retrieving results.
    next_token: ?[]const u8,

    /// The name of the SageMaker resource to search for.
    resource: ResourceType,

    /// A Boolean conditional statement. Resources must satisfy this condition to be
    /// included in search results. You must provide at least one subexpression,
    /// filter, or nested filter. The maximum number of recursive `SubExpressions`,
    /// `NestedFilters`, and `Filters` that can be included in a `SearchExpression`
    /// object is 50.
    search_expression: ?SearchExpression,

    /// The name of the resource property used to sort the `SearchResults`. The
    /// default is `LastModifiedTime`.
    sort_by: ?[]const u8,

    /// How `SearchResults` are ordered. Valid values are `Ascending` or
    /// `Descending`. The default is `Descending`.
    sort_order: ?SearchSortOrder,

    /// Limits the results of your search request to the resources that you can
    /// access.
    visibility_conditions: ?[]const VisibilityConditions,

    pub const json_field_names = .{
        .cross_account_filter_option = "CrossAccountFilterOption",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource = "Resource",
        .search_expression = "SearchExpression",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .visibility_conditions = "VisibilityConditions",
    };
};
