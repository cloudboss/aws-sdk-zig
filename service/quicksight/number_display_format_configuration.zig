const DecimalPlacesConfiguration = @import("decimal_places_configuration.zig").DecimalPlacesConfiguration;
const NegativeValueConfiguration = @import("negative_value_configuration.zig").NegativeValueConfiguration;
const NullValueFormatConfiguration = @import("null_value_format_configuration.zig").NullValueFormatConfiguration;
const NumberScale = @import("number_scale.zig").NumberScale;
const NumericSeparatorConfiguration = @import("numeric_separator_configuration.zig").NumericSeparatorConfiguration;

/// The options that determine the number display format configuration.
pub const NumberDisplayFormatConfiguration = struct {
    /// The option that determines the decimal places configuration.
    decimal_places_configuration: ?DecimalPlacesConfiguration,

    /// The options that determine the negative value configuration.
    negative_value_configuration: ?NegativeValueConfiguration,

    /// The options that determine the null value format configuration.
    null_value_format_configuration: ?NullValueFormatConfiguration,

    /// Determines the number scale value of the number format.
    number_scale: ?NumberScale,

    /// Determines the prefix value of the number format.
    prefix: ?[]const u8,

    /// The options that determine the numeric separator configuration.
    separator_configuration: ?NumericSeparatorConfiguration,

    /// Determines the suffix value of the number format.
    suffix: ?[]const u8,

    pub const json_field_names = .{
        .decimal_places_configuration = "DecimalPlacesConfiguration",
        .negative_value_configuration = "NegativeValueConfiguration",
        .null_value_format_configuration = "NullValueFormatConfiguration",
        .number_scale = "NumberScale",
        .prefix = "Prefix",
        .separator_configuration = "SeparatorConfiguration",
        .suffix = "Suffix",
    };
};
