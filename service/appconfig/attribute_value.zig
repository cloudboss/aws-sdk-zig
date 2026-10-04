/// A value for a feature flag attribute. Only one of the members can be set.
pub const AttributeValue = union(enum) {
    /// A Boolean value for the attribute.
    boolean_value: ?bool,
    /// An array of numeric values for the attribute.
    number_array: ?[]const f64,
    /// A numeric value for the attribute.
    number_value: ?f64,
    /// An array of string values for the attribute.
    string_array: ?[]const []const u8,
    /// A string value for the attribute.
    string_value: ?[]const u8,

    pub const json_field_names = .{
        .boolean_value = "BooleanValue",
        .number_array = "NumberArray",
        .number_value = "NumberValue",
        .string_array = "StringArray",
        .string_value = "StringValue",
    };
};
