/// Contains an array.
pub const ArrayValue = union(enum) {
    /// An array of arrays. Can contain null values.
    array_values: ?[]const ArrayValue,
    /// An array of Boolean values. Can contain null values.
    boolean_values: ?[]const bool,
    /// An array of floating-point numbers. Can contain null values.
    double_values: ?[]const f64,
    /// An array of integers. Can contain null values.
    long_values: ?[]const i64,
    /// An array of strings. Can contain null values.
    string_values: ?[]const []const u8,

    pub const json_field_names = .{
        .array_values = "arrayValues",
        .boolean_values = "booleanValues",
        .double_values = "doubleValues",
        .long_values = "longValues",
        .string_values = "stringValues",
    };
};
