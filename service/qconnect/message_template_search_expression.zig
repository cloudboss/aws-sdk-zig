const MessageTemplateFilterField = @import("message_template_filter_field.zig").MessageTemplateFilterField;
const MessageTemplateOrderField = @import("message_template_order_field.zig").MessageTemplateOrderField;
const MessageTemplateQueryField = @import("message_template_query_field.zig").MessageTemplateQueryField;

/// The search expression of the message template.
pub const MessageTemplateSearchExpression = struct {
    /// The configuration of filtering rules applied to message template query
    /// results.
    filters: ?[]const MessageTemplateFilterField,

    /// The message template attribute fields on which the query results are
    /// ordered.
    order_on_field: ?MessageTemplateOrderField,

    /// The message template query expressions.
    queries: ?[]const MessageTemplateQueryField,

    pub const json_field_names = .{
        .filters = "filters",
        .order_on_field = "orderOnField",
        .queries = "queries",
    };
};
