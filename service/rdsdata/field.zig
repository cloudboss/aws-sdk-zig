const ArrayValue = @import("array_value.zig").ArrayValue;

/// Contains a value.
pub const Field = union(enum) {
    /// An array of values.
    array_value: ?ArrayValue,
    /// A value of BLOB data type.
    blob_value: ?[]const u8,
    /// A value of Boolean data type.
    boolean_value: ?bool,
    /// A value of double data type.
    double_value: ?f64,
    /// A NULL value.
    is_null: ?bool,
    /// A value of long data type.
    long_value: ?i64,
    /// A value of string data type.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .array_value = "arrayValue",
        .blob_value = "blobValue",
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .is_null = "isNull",
        .long_value = "longValue",
        .string_value = "stringValue",
    };
};
