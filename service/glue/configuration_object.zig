/// Specifies the values that an admin sets for each job or session parameter
/// configured in a Glue usage profile.
pub const ConfigurationObject = struct {
    /// A list of allowed values for the parameter.
    allowed_values: ?[]const []const u8,

    /// A default value for the parameter.
    default_value: ?[]const u8,

    /// A maximum allowed value for the parameter.
    max_value: ?[]const u8,

    /// A minimum allowed value for the parameter.
    min_value: ?[]const u8,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .default_value = "DefaultValue",
        .max_value = "MaxValue",
        .min_value = "MinValue",
    };
};
