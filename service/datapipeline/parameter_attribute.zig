/// The attributes allowed or specified with a parameter object.
pub const ParameterAttribute = struct {
    /// The field identifier.
    key: []const u8,

    /// The field value, expressed as a String.
    string_value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .string_value = "stringValue",
    };
};
