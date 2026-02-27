/// Represents a specific change to be made to a benefit application field.
pub const Amendment = struct {
    /// The JSON path or field identifier specifying which field in the benefit
    /// application to modify.
    field_path: []const u8,

    /// The new value to set for the specified field in the benefit application.
    new_value: []const u8,

    pub const json_field_names = .{
        .field_path = "FieldPath",
        .new_value = "NewValue",
    };
};
