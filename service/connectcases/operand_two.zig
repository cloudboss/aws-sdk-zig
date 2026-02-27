const EmptyOperandValue = @import("empty_operand_value.zig").EmptyOperandValue;

/// Represents the right hand operand in the condition. In the Amazon Connect
/// admin website, case rules are known as *case field conditions*. For more
/// information about case field conditions, see [Add case field conditions to a
/// case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const OperandTwo = union(enum) {
    /// Boolean value type.
    boolean_value: ?bool,
    /// Double value type.
    double_value: ?f64,
    /// Empty value type.
    empty_value: ?EmptyOperandValue,
    /// String value type.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .empty_value = "emptyValue",
        .string_value = "stringValue",
    };
};
