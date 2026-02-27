/// Validation rules for a text field.
pub const TextValidation = struct {
    /// The maximum number of characters for the text field.
    max_length: i32,

    /// The minimum number of characters for the text field.
    min_length: i32,

    /// The regular expression used to validate the text field.
    pattern: []const u8,

    pub const json_field_names = .{
        .max_length = "MaxLength",
        .min_length = "MinLength",
        .pattern = "Pattern",
    };
};
