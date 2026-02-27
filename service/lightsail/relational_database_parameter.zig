/// Describes the parameters of a database.
pub const RelationalDatabaseParameter = struct {
    /// Specifies the valid range of values for the parameter.
    allowed_values: ?[]const u8,

    /// Indicates when parameter updates are applied.
    ///
    /// Can be `immediate` or `pending-reboot`.
    apply_method: ?[]const u8,

    /// Specifies the engine-specific parameter type.
    apply_type: ?[]const u8,

    /// Specifies the valid data type for the parameter.
    data_type: ?[]const u8,

    /// Provides a description of the parameter.
    description: ?[]const u8,

    /// A Boolean value indicating whether the parameter can be modified.
    is_modifiable: ?bool,

    /// Specifies the name of the parameter.
    parameter_name: ?[]const u8,

    /// Specifies the value of the parameter.
    parameter_value: ?[]const u8,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .apply_method = "applyMethod",
        .apply_type = "applyType",
        .data_type = "dataType",
        .description = "description",
        .is_modifiable = "isModifiable",
        .parameter_name = "parameterName",
        .parameter_value = "parameterValue",
    };
};
