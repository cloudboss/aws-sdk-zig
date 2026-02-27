/// Use the AttributeValueList to filter by string or integer values.
pub const AttributeValueList = union(enum) {
    /// The list of integer values that the filter matches.
    integer_values: ?[]const i32,
    /// The list of string values that the filter matches.
    string_values: ?[]const []const u8,

    pub const json_field_names = .{
        .integer_values = "integerValues",
        .string_values = "stringValues",
    };
};
