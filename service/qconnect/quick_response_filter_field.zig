const QuickResponseFilterOperator = @import("quick_response_filter_operator.zig").QuickResponseFilterOperator;

/// The quick response fields to filter the quick response query results by.
///
/// The following is the list of supported field names.
///
/// * name
/// * description
/// * shortcutKey
/// * isActive
/// * channels
/// * language
/// * contentType
/// * createdTime
/// * lastModifiedTime
/// * lastModifiedBy
/// * groupingConfiguration.criteria
/// * groupingConfiguration.values
pub const QuickResponseFilterField = struct {
    /// Whether to treat null value as a match for the attribute field.
    include_no_existence: ?bool = null,

    /// The name of the attribute field to filter the quick responses by.
    name: []const u8,

    /// The operator to use for filtering.
    operator: QuickResponseFilterOperator,

    /// The values of attribute field to filter the quick response by.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .include_no_existence = "includeNoExistence",
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
