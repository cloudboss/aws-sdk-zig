/// The options for customizing a security control parameter that is a list of
/// enums.
pub const EnumListConfigurationOptions = struct {
    /// The valid values for a control parameter that is a list of enums.
    allowed_values: ?[]const []const u8,

    /// The Security Hub default value for a control parameter that is a list of
    /// enums.
    default_value: ?[]const []const u8,

    /// The maximum number of list items that an enum list control parameter can
    /// accept.
    max_items: ?i32,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .default_value = "DefaultValue",
        .max_items = "MaxItems",
    };
};
