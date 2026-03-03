/// The options for customizing a security control parameter that is an enum.
pub const EnumConfigurationOptions = struct {
    /// The valid values for a control parameter that is an enum.
    allowed_values: ?[]const []const u8 = null,

    /// The Security Hub default value for a control parameter that is an enum.
    default_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .default_value = "DefaultValue",
    };
};
