/// Describes the configuration settings for the form's style properties.
pub const FormStyleConfig = union(enum) {
    /// A reference to a design token to use to bind the form's style properties to
    /// an existing
    /// theme.
    token_reference: ?[]const u8,
    /// The value of the style setting.
    value: ?[]const u8,

    pub const json_field_names = .{
        .token_reference = "tokenReference",
        .value = "value",
    };
};
