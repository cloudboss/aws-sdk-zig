const DecimalPlacesConfiguration = @import("decimal_places_configuration.zig").DecimalPlacesConfiguration;
const NegativeValueConfiguration = @import("negative_value_configuration.zig").NegativeValueConfiguration;
const NullValueFormatConfiguration = @import("null_value_format_configuration.zig").NullValueFormatConfiguration;
const NumberScale = @import("number_scale.zig").NumberScale;
const NumericSeparatorConfiguration = @import("numeric_separator_configuration.zig").NumericSeparatorConfiguration;

/// The options that determine the currency display format configuration.
pub const CurrencyDisplayFormatConfiguration = struct {
    /// The option that determines the decimal places configuration.
    decimal_places_configuration: ?DecimalPlacesConfiguration = null,

    /// The options that determine the negative value configuration.
    negative_value_configuration: ?NegativeValueConfiguration = null,

    /// The options that determine the null value format configuration.
    null_value_format_configuration: ?NullValueFormatConfiguration = null,

    /// Determines the number scale value for the currency format.
    number_scale: ?NumberScale = null,

    /// Determines the prefix value of the currency format.
    prefix: ?[]const u8 = null,

    /// The options that determine the numeric separator configuration.
    separator_configuration: ?NumericSeparatorConfiguration = null,

    /// Determines the suffix value of the currency format.
    suffix: ?[]const u8 = null,

    /// Determines the symbol for the currency format.
    symbol: ?[]const u8 = null,

    pub const json_field_names = .{
        .decimal_places_configuration = "DecimalPlacesConfiguration",
        .negative_value_configuration = "NegativeValueConfiguration",
        .null_value_format_configuration = "NullValueFormatConfiguration",
        .number_scale = "NumberScale",
        .prefix = "Prefix",
        .separator_configuration = "SeparatorConfiguration",
        .suffix = "Suffix",
        .symbol = "Symbol",
    };
};
