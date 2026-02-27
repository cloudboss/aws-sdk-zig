const StructValue = @import("struct_value.zig").StructValue;

/// Contains the value of a column.
///
/// This data structure is only used with the deprecated `ExecuteSql` operation.
/// Use the `BatchExecuteStatement` or `ExecuteStatement` operation instead.
pub const Value = union(enum) {
    /// An array of column values.
    array_values: ?[]const Value,
    /// A value for a column of big integer data type.
    big_int_value: ?i64,
    /// A value for a column of BIT data type.
    bit_value: ?bool,
    /// A value for a column of BLOB data type.
    blob_value: ?[]const u8,
    /// A value for a column of double data type.
    double_value: ?f64,
    /// A value for a column of integer data type.
    int_value: ?i32,
    /// A NULL value.
    is_null: ?bool,
    /// A value for a column of real data type.
    real_value: ?f32,
    /// A value for a column of string data type.
    string_value: ?[]const u8,
    /// A value for a column of STRUCT data type.
    struct_value: ?StructValue,

    pub const json_field_names = .{
        .array_values = "arrayValues",
        .big_int_value = "bigIntValue",
        .bit_value = "bitValue",
        .blob_value = "blobValue",
        .double_value = "doubleValue",
        .int_value = "intValue",
        .is_null = "isNull",
        .real_value = "realValue",
        .string_value = "stringValue",
        .struct_value = "structValue",
    };
};
