const StringFilter = @import("string_filter.zig").StringFilter;
const LambdaLayerSortBy = @import("lambda_layer_sort_by.zig").LambdaLayerSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define a findings aggregation based on an Amazon Web
/// Services Lambda
/// function's layers.
pub const LambdaLayerAggregation = struct {
    /// The names of the Amazon Web Services Lambda functions associated with the
    /// layers.
    function_names: ?[]const StringFilter = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Lambda function
    /// layer.
    layer_arns: ?[]const StringFilter = null,

    /// The resource IDs for the Amazon Web Services Lambda function layers.
    resource_ids: ?[]const StringFilter = null,

    /// The finding severity to use for sorting the results.
    sort_by: ?LambdaLayerSortBy = null,

    /// The order to use for sorting the results.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .function_names = "functionNames",
        .layer_arns = "layerArns",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
