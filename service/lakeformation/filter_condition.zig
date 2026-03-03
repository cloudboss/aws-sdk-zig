const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const FieldNameString = @import("field_name_string.zig").FieldNameString;

/// This structure describes the filtering of columns in a table based on a
/// filter condition.
pub const FilterCondition = struct {
    /// The comparison operator used in the filter condition.
    comparison_operator: ?ComparisonOperator = null,

    /// The field to filter in the filter condition.
    field: ?FieldNameString = null,

    /// A string with values used in evaluating the filter condition.
    string_value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .field = "Field",
        .string_value_list = "StringValueList",
    };
};
