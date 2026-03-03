const NumericSeparatorSymbol = @import("numeric_separator_symbol.zig").NumericSeparatorSymbol;
const ThousandSeparatorOptions = @import("thousand_separator_options.zig").ThousandSeparatorOptions;

/// The options that determine the numeric separator configuration.
pub const NumericSeparatorConfiguration = struct {
    /// Determines the decimal separator.
    decimal_separator: ?NumericSeparatorSymbol = null,

    /// The options that determine the thousands separator configuration.
    thousands_separator: ?ThousandSeparatorOptions = null,

    pub const json_field_names = .{
        .decimal_separator = "DecimalSeparator",
        .thousands_separator = "ThousandsSeparator",
    };
};
