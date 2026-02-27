const MessageTemplateQueryOperator = @import("message_template_query_operator.zig").MessageTemplateQueryOperator;
const Priority = @import("priority.zig").Priority;

/// The message template fields to query message templates by. The following is
/// the list of supported field names:
///
/// * name
/// * description
pub const MessageTemplateQueryField = struct {
    /// Whether the query expects only exact matches on the attribute field values.
    /// The results of the query will only include exact matches if this parameter
    /// is set to false.
    allow_fuzziness: ?bool,

    /// The name of the attribute to query the message templates by.
    name: []const u8,

    /// The operator to use for matching attribute field values in the query.
    operator: MessageTemplateQueryOperator,

    /// The importance of the attribute field when calculating query result
    /// relevancy scores. The value set for this parameter affects the ordering of
    /// search results.
    priority: ?Priority,

    /// The values of the attribute to query the message templates by.
    values: []const []const u8,

    pub const json_field_names = .{
        .allow_fuzziness = "allowFuzziness",
        .name = "name",
        .operator = "operator",
        .priority = "priority",
        .values = "values",
    };
};
