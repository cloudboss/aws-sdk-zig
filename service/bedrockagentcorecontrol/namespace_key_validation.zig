/// The validation rules for namespace variable values. When you specify
/// multiple rules, the service enforces a logical `AND` across all provided
/// key-value pairs.
pub const NamespaceKeyValidation = struct {
    /// The allowed values for this namespace variable key.
    allowed_values: ?[]const []const u8 = null,

    /// A regex pattern that the namespace variable key-value must match.
    regex_pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .regex_pattern = "regexPattern",
    };
};
