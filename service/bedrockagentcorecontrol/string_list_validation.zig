/// Validation for STRINGLIST fields.
pub const StringListValidation = struct {
    /// Allowed values for items in this STRINGLIST field.
    allowed_values: ?[]const []const u8 = null,

    /// Maximum number of items in the string list.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .max_items = "maxItems",
    };
};
