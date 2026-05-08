/// Validation for STRING fields.
pub const StringValidation = struct {
    /// Allowed values for this STRING field.
    allowed_values: []const []const u8,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
    };
};
