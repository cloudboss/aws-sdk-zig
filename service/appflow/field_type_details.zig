const Range = @import("range.zig").Range;
const Operator = @import("operator.zig").Operator;

/// Contains details regarding the supported field type and the operators that
/// can be applied
/// for filtering.
pub const FieldTypeDetails = struct {
    /// This is the allowable length range for this field's value.
    field_length_range: ?Range = null,

    /// The type of field, such as string, integer, date, and so on.
    field_type: []const u8,

    /// The range of values this field can hold.
    field_value_range: ?Range = null,

    /// The list of operators supported by a field.
    filter_operators: []const Operator,

    /// The date format that the field supports.
    supported_date_format: ?[]const u8 = null,

    /// The list of values that a field can contain. For example, a Boolean
    /// `fieldType` can have two values: "true" and "false".
    supported_values: ?[]const []const u8 = null,

    /// The regular expression pattern for the field name.
    value_regex_pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_length_range = "fieldLengthRange",
        .field_type = "fieldType",
        .field_value_range = "fieldValueRange",
        .filter_operators = "filterOperators",
        .supported_date_format = "supportedDateFormat",
        .supported_values = "supportedValues",
        .value_regex_pattern = "valueRegexPattern",
    };
};
