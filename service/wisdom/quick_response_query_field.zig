const QuickResponseQueryOperator = @import("quick_response_query_operator.zig").QuickResponseQueryOperator;
const Priority = @import("priority.zig").Priority;

/// The quick response fields to query quick responses by.
///
/// The following is the list of supported field names.
///
/// * content
///
/// * name
///
/// * description
///
/// * shortcutKey
pub const QuickResponseQueryField = struct {
    /// Whether the query expects only exact matches on the attribute field values.
    /// The results of the query will only include exact matches if this parameter
    /// is set to false.
    allow_fuzziness: ?bool,

    /// The name of the attribute to query the quick responses by.
    name: []const u8,

    /// The operator to use for matching attribute field values in the query.
    operator: QuickResponseQueryOperator,

    /// The importance of the attribute field when calculating query result
    /// relevancy scores.
    /// The value set for this parameter affects the ordering of search results.
    priority: ?Priority,

    /// The values of the attribute to query the quick responses by.
    values: []const []const u8,

    pub const json_field_names = .{
        .allow_fuzziness = "allowFuzziness",
        .name = "name",
        .operator = "operator",
        .priority = "priority",
        .values = "values",
    };
};
