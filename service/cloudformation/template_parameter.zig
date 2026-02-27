/// The `TemplateParameter` data type.
pub const TemplateParameter = struct {
    /// The default value associated with the parameter.
    default_value: ?[]const u8,

    /// User defined description associated with the parameter.
    description: ?[]const u8,

    /// Flag indicating whether the parameter should be displayed as plain text in
    /// logs and
    /// UIs.
    no_echo: ?bool,

    /// The name associated with the parameter.
    parameter_key: ?[]const u8,
};
