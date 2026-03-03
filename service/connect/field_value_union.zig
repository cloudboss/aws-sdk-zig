const EmptyFieldValue = @import("empty_field_value.zig").EmptyFieldValue;

/// Object to store union of Field values.
pub const FieldValueUnion = struct {
    /// A Boolean number value type.
    boolean_value: bool = false,

    /// A Double number value type.
    double_value: ?f64 = null,

    /// An empty value.
    empty_value: ?EmptyFieldValue = null,

    /// String value type.
    string_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .boolean_value = "BooleanValue",
        .double_value = "DoubleValue",
        .empty_value = "EmptyValue",
        .string_value = "StringValue",
    };
};
