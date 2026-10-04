/// Per-rule validation constraints that override the field's default validation
/// when the containing rule matches. All fields are optional; only the
/// constraints that need to differ from the field's default validation are
/// provided.
pub const ConditionalValidation = struct {
    /// The allowed values for a select field when this rule applies. A subset of
    /// the field's full option list.
    allowed_values: ?[]const []const u8 = null,

    /// The maximum length for the field value when this rule applies.
    max_length: ?i32 = null,

    /// The minimum length for the field value when this rule applies.
    min_length: ?i32 = null,

    /// A regular expression that the field value must match when this rule applies.
    pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .max_length = "MaxLength",
        .min_length = "MinLength",
        .pattern = "Pattern",
    };
};
