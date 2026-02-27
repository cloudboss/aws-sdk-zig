/// Contains an array.
pub const ArrayValue = union(enum) {
    /// An array of arrays.
    array_values: ?[]const ArrayValue,
    /// An array of Boolean values.
    boolean_values: ?[]const bool,
    /// An array of floating-point numbers.
    double_values: ?[]const f64,
    /// An array of integers.
    long_values: ?[]const i64,
    /// An array of strings.
    string_values: ?[]const []const u8,

    pub const json_field_names = .{
        .array_values = "arrayValues",
        .boolean_values = "booleanValues",
        .double_values = "doubleValues",
        .long_values = "longValues",
        .string_values = "stringValues",
    };
};
