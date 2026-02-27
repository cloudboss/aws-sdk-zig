const QuickResponseFilterField = @import("quick_response_filter_field.zig").QuickResponseFilterField;
const QuickResponseOrderField = @import("quick_response_order_field.zig").QuickResponseOrderField;
const QuickResponseQueryField = @import("quick_response_query_field.zig").QuickResponseQueryField;

/// Information about the import job.
pub const QuickResponseSearchExpression = struct {
    /// The configuration of filtering rules applied to quick response query
    /// results.
    filters: ?[]const QuickResponseFilterField,

    /// The quick response attribute fields on which the query results are ordered.
    order_on_field: ?QuickResponseOrderField,

    /// The quick response query expressions.
    queries: ?[]const QuickResponseQueryField,

    pub const json_field_names = .{
        .filters = "filters",
        .order_on_field = "orderOnField",
        .queries = "queries",
    };
};
