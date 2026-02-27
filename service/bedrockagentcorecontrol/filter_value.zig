/// The value used in filter comparisons, supporting different data types for
/// flexible filtering criteria.
pub const FilterValue = union(enum) {
    /// The boolean value for true/false filtering conditions.
    boolean_value: ?bool,
    /// The numeric value for numerical filtering and comparisons.
    double_value: ?f64,
    /// The string value for text-based filtering.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .string_value = "stringValue",
    };
};
