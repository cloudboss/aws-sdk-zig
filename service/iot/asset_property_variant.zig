/// Contains an asset property value (of a single type).
pub const AssetPropertyVariant = union(enum) {
    /// Optional. A string that contains the boolean value (`true` or
    /// `false`) of the value entry. Accepts substitution templates.
    boolean_value: ?[]const u8,
    /// Optional. A string that contains the double value of the value entry.
    /// Accepts substitution
    /// templates.
    double_value: ?[]const u8,
    /// Optional. A string that contains the integer value of the value entry.
    /// Accepts
    /// substitution templates.
    integer_value: ?[]const u8,
    /// Optional. The string value of the value entry. Accepts substitution
    /// templates.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .double_value = "doubleValue",
        .integer_value = "integerValue",
        .string_value = "stringValue",
    };
};
