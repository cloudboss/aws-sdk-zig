const DecimalPlacesConfiguration = @import("decimal_places_configuration.zig").DecimalPlacesConfiguration;
const NegativeValueConfiguration = @import("negative_value_configuration.zig").NegativeValueConfiguration;
const NullValueFormatConfiguration = @import("null_value_format_configuration.zig").NullValueFormatConfiguration;
const NumericSeparatorConfiguration = @import("numeric_separator_configuration.zig").NumericSeparatorConfiguration;

/// The options that determine the percentage display format configuration.
pub const PercentageDisplayFormatConfiguration = struct {
    /// The option that determines the decimal places configuration.
    decimal_places_configuration: ?DecimalPlacesConfiguration = null,

    /// The options that determine the negative value configuration.
    negative_value_configuration: ?NegativeValueConfiguration = null,

    /// The options that determine the null value format configuration.
    null_value_format_configuration: ?NullValueFormatConfiguration = null,

    /// Determines the prefix value of the percentage format.
    prefix: ?[]const u8 = null,

    /// The options that determine the numeric separator configuration.
    separator_configuration: ?NumericSeparatorConfiguration = null,

    /// Determines the suffix value of the percentage format.
    suffix: ?[]const u8 = null,

    pub const json_field_names = .{
        .decimal_places_configuration = "DecimalPlacesConfiguration",
        .negative_value_configuration = "NegativeValueConfiguration",
        .null_value_format_configuration = "NullValueFormatConfiguration",
        .prefix = "Prefix",
        .separator_configuration = "SeparatorConfiguration",
        .suffix = "Suffix",
    };
};
