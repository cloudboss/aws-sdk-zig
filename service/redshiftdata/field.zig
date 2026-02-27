/// A data value in a column.
pub const Field = union(enum) {
    /// A value of the BLOB data type.
    blob_value: ?[]const u8,
    /// A value of the Boolean data type.
    boolean_value: ?bool,
    /// A value of the double data type.
    double_value: ?f64,
    /// A value that indicates whether the data is NULL.
    is_null: ?bool,
    /// A value of the long data type.
    long_value: ?i64,
    /// A value of the string data type.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .blob_value = "blobValue",
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .is_null = "isNull",
        .long_value = "longValue",
        .string_value = "stringValue",
    };
};
