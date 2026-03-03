const CommandParameterValueNumberRange = @import("command_parameter_value_number_range.zig").CommandParameterValueNumberRange;

/// The comparison operand used to compare the defined value against the value
/// supplied in request.
pub const CommandParameterValueComparisonOperand = struct {
    /// An operand of number value type, defined as a string.
    number: ?[]const u8 = null,

    /// An operand of numerical range value type.
    number_range: ?CommandParameterValueNumberRange = null,

    /// A List of operands of numerical value type, defined as strings.
    numbers: ?[]const []const u8 = null,

    /// An operand of string value type.
    string: ?[]const u8 = null,

    /// A List of operands of string value type.
    strings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .number = "number",
        .number_range = "numberRange",
        .numbers = "numbers",
        .string = "string",
        .strings = "strings",
    };
};
