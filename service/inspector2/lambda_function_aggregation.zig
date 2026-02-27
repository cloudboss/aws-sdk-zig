const StringFilter = @import("string_filter.zig").StringFilter;
const MapFilter = @import("map_filter.zig").MapFilter;
const LambdaFunctionSortBy = @import("lambda_function_sort_by.zig").LambdaFunctionSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define a findings aggregation based on Amazon Web Services
/// Lambda
/// functions.
pub const LambdaFunctionAggregation = struct {
    /// The Amazon Web Services Lambda function names to include in the aggregation
    /// results.
    function_names: ?[]const StringFilter,

    /// The tags to include in the aggregation results.
    function_tags: ?[]const MapFilter,

    /// The resource IDs to include in the aggregation results.
    resource_ids: ?[]const StringFilter,

    /// Returns findings aggregated by Amazon Web Services Lambda function runtime
    /// environments.
    runtimes: ?[]const StringFilter,

    /// The finding severity to use for sorting the results.
    sort_by: ?LambdaFunctionSortBy,

    /// The order to use for sorting the results.
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .function_names = "functionNames",
        .function_tags = "functionTags",
        .resource_ids = "resourceIds",
        .runtimes = "runtimes",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
