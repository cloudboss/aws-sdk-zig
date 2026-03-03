const TopicNumericSeparatorSymbol = @import("topic_numeric_separator_symbol.zig").TopicNumericSeparatorSymbol;
const NegativeFormat = @import("negative_format.zig").NegativeFormat;
const NumberScale = @import("number_scale.zig").NumberScale;

/// A structure that represents additional options for display formatting.
pub const DisplayFormatOptions = struct {
    /// Determines the blank cell format.
    blank_cell_format: ?[]const u8 = null,

    /// The currency symbol, such as `USD`.
    currency_symbol: ?[]const u8 = null,

    /// Determines the `DateTime` format.
    date_format: ?[]const u8 = null,

    /// Determines the decimal separator.
    decimal_separator: ?TopicNumericSeparatorSymbol = null,

    /// Determines the number of fraction digits.
    fraction_digits: i32 = 0,

    /// Determines the grouping separator.
    grouping_separator: ?[]const u8 = null,

    /// The negative format.
    negative_format: ?NegativeFormat = null,

    /// The prefix value for a display format.
    prefix: ?[]const u8 = null,

    /// The suffix value for a display format.
    suffix: ?[]const u8 = null,

    /// The unit scaler. Valid values for this structure are: `NONE`,
    /// `AUTO`, `THOUSANDS`, `MILLIONS`,
    /// `BILLIONS`,
    /// and `TRILLIONS`.
    unit_scaler: ?NumberScale = null,

    /// A Boolean value that indicates whether to use blank cell format.
    use_blank_cell_format: bool = false,

    /// A Boolean value that indicates whether to use grouping.
    use_grouping: bool = false,

    pub const json_field_names = .{
        .blank_cell_format = "BlankCellFormat",
        .currency_symbol = "CurrencySymbol",
        .date_format = "DateFormat",
        .decimal_separator = "DecimalSeparator",
        .fraction_digits = "FractionDigits",
        .grouping_separator = "GroupingSeparator",
        .negative_format = "NegativeFormat",
        .prefix = "Prefix",
        .suffix = "Suffix",
        .unit_scaler = "UnitScaler",
        .use_blank_cell_format = "UseBlankCellFormat",
        .use_grouping = "UseGrouping",
    };
};
