/// Describes the validation configuration for a field.
pub const FieldValidationConfiguration = struct {
    /// The validation to perform on a number value.
    num_values: ?[]const i32,

    /// The validation to perform on a string value.
    str_values: ?[]const []const u8,

    /// The validation to perform on an object type.
    type: []const u8,

    /// The validation message to display.
    validation_message: ?[]const u8,

    pub const json_field_names = .{
        .num_values = "numValues",
        .str_values = "strValues",
        .type = "type",
        .validation_message = "validationMessage",
    };
};
