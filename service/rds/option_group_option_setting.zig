const MinimumEngineVersionPerAllowedValue = @import("minimum_engine_version_per_allowed_value.zig").MinimumEngineVersionPerAllowedValue;

/// Option group option settings are used to display settings available for each
/// option with their default values and other information. These values are
/// used with the DescribeOptionGroupOptions action.
pub const OptionGroupOptionSetting = struct {
    /// Indicates the acceptable values for the option group option.
    allowed_values: ?[]const u8,

    /// The DB engine specific parameter type for the option group option.
    apply_type: ?[]const u8,

    /// The default value for the option group option.
    default_value: ?[]const u8,

    /// Indicates whether this option group option can be changed from the default
    /// value.
    is_modifiable: ?bool,

    /// Indicates whether a value must be specified for this option setting of the
    /// option group option.
    is_required: ?bool,

    /// The minimum DB engine version required for the corresponding allowed value
    /// for this option setting.
    minimum_engine_version_per_allowed_value: ?[]const MinimumEngineVersionPerAllowedValue,

    /// The description of the option group option.
    setting_description: ?[]const u8,

    /// The name of the option group option.
    setting_name: ?[]const u8,
};
