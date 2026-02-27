/// Option settings are the actual settings being applied or configured for that
/// option. It is used when you modify an option group or describe option
/// groups. For example, the NATIVE_NETWORK_ENCRYPTION option has a setting
/// called SQLNET.ENCRYPTION_SERVER that can have several different values.
pub const OptionSetting = struct {
    /// The allowed values of the option setting.
    allowed_values: ?[]const u8,

    /// The DB engine specific parameter type.
    apply_type: ?[]const u8,

    /// The data type of the option setting.
    data_type: ?[]const u8,

    /// The default value of the option setting.
    default_value: ?[]const u8,

    /// The description of the option setting.
    description: ?[]const u8,

    /// Indicates whether the option setting is part of a collection.
    is_collection: ?bool,

    /// Indicates whether the option setting can be modified from the default.
    is_modifiable: ?bool,

    /// The name of the option that has settings that you can set.
    name: ?[]const u8,

    /// The current value of the option setting.
    value: ?[]const u8,
};
