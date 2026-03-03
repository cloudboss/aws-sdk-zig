const DigitGroupingStyle = @import("digit_grouping_style.zig").DigitGroupingStyle;
const NumericSeparatorSymbol = @import("numeric_separator_symbol.zig").NumericSeparatorSymbol;
const Visibility = @import("visibility.zig").Visibility;

/// The options that determine the thousands separator configuration.
pub const ThousandSeparatorOptions = struct {
    /// Determines the way numbers are styled to accommodate different readability
    /// standards. The `DEFAULT` value uses the standard international grouping
    /// system and groups numbers by the thousands. The `LAKHS` value uses the
    /// Indian numbering system and groups numbers by lakhs and crores.
    grouping_style: ?DigitGroupingStyle = null,

    /// Determines the thousands separator symbol.
    symbol: ?NumericSeparatorSymbol = null,

    /// Determines the visibility of the thousands separator.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .grouping_style = "GroupingStyle",
        .symbol = "Symbol",
        .visibility = "Visibility",
    };
};
