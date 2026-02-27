/// A value or list of parameter values.
pub const ParameterValue = struct {
    /// The ID of the parameter value.
    id: []const u8,

    /// The field value, expressed as a String.
    string_value: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .string_value = "stringValue",
    };
};
