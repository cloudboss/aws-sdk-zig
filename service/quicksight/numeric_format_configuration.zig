const CurrencyDisplayFormatConfiguration = @import("currency_display_format_configuration.zig").CurrencyDisplayFormatConfiguration;
const NumberDisplayFormatConfiguration = @import("number_display_format_configuration.zig").NumberDisplayFormatConfiguration;
const PercentageDisplayFormatConfiguration = @import("percentage_display_format_configuration.zig").PercentageDisplayFormatConfiguration;

/// The options that determine the numeric format configuration.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const NumericFormatConfiguration = struct {
    /// The options that determine the currency display format configuration.
    currency_display_format_configuration: ?CurrencyDisplayFormatConfiguration,

    /// The options that determine the number display format configuration.
    number_display_format_configuration: ?NumberDisplayFormatConfiguration,

    /// The options that determine the percentage display format configuration.
    percentage_display_format_configuration: ?PercentageDisplayFormatConfiguration,

    pub const json_field_names = .{
        .currency_display_format_configuration = "CurrencyDisplayFormatConfiguration",
        .number_display_format_configuration = "NumberDisplayFormatConfiguration",
        .percentage_display_format_configuration = "PercentageDisplayFormatConfiguration",
    };
};
