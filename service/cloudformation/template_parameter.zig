/// The `TemplateParameter` data type.
pub const TemplateParameter = struct {
    /// The default value associated with the parameter.
    default_value: ?[]const u8 = null,

    /// User defined description associated with the parameter.
    description: ?[]const u8 = null,

    /// Flag indicating whether the parameter should be displayed as plain text in
    /// logs and
    /// UIs.
    no_echo: ?bool = null,

    /// The name associated with the parameter.
    parameter_key: ?[]const u8 = null,
};
