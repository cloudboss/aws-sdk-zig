/// The details of user parameters of an environment blueprint.
pub const CustomParameter = struct {
    /// The default value of the parameter.
    default_value: ?[]const u8 = null,

    /// The description of the parameter.
    description: ?[]const u8 = null,

    /// The filed type of the parameter.
    field_type: []const u8,

    /// Specifies whether the parameter is editable.
    is_editable: ?bool = null,

    /// Specifies whether the custom parameter is optional.
    is_optional: ?bool = null,

    /// Specifies whether a parameter value can be updated after creation.
    is_update_supported: ?bool = null,

    /// The key name of the parameter.
    key_name: []const u8,

    pub const json_field_names = .{
        .default_value = "defaultValue",
        .description = "description",
        .field_type = "fieldType",
        .is_editable = "isEditable",
        .is_optional = "isOptional",
        .is_update_supported = "isUpdateSupported",
        .key_name = "keyName",
    };
};
