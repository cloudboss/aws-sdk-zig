const CsvHeaderOption = @import("csv_header_option.zig").CsvHeaderOption;
const CsvSerdeOption = @import("csv_serde_option.zig").CsvSerdeOption;

/// Specifies a custom CSV classifier to be updated.
pub const UpdateCsvClassifierRequest = struct {
    /// Enables the processing of files that contain only one column.
    allow_single_column: ?bool = null,

    /// Indicates whether the CSV file contains a header.
    contains_header: ?CsvHeaderOption = null,

    /// Specifies the configuration of custom datatypes.
    custom_datatype_configured: ?bool = null,

    /// Specifies a list of supported custom datatypes.
    custom_datatypes: ?[]const []const u8 = null,

    /// A custom symbol to denote what separates each column entry in the row.
    delimiter: ?[]const u8 = null,

    /// Specifies not to trim values before identifying the type of column values.
    /// The default value is true.
    disable_value_trimming: ?bool = null,

    /// A list of strings representing column names.
    header: ?[]const []const u8 = null,

    /// The name of the classifier.
    name: []const u8,

    /// A custom symbol to denote what combines content into a single column value.
    /// It must be
    /// different from the column delimiter.
    quote_symbol: ?[]const u8 = null,

    /// Sets the SerDe for processing CSV in the classifier, which will be applied
    /// in the Data Catalog. Valid values are `OpenCSVSerDe`, `LazySimpleSerDe`, and
    /// `None`. You can specify the `None` value when you want the crawler to do the
    /// detection.
    serde: ?CsvSerdeOption = null,

    pub const json_field_names = .{
        .allow_single_column = "AllowSingleColumn",
        .contains_header = "ContainsHeader",
        .custom_datatype_configured = "CustomDatatypeConfigured",
        .custom_datatypes = "CustomDatatypes",
        .delimiter = "Delimiter",
        .disable_value_trimming = "DisableValueTrimming",
        .header = "Header",
        .name = "Name",
        .quote_symbol = "QuoteSymbol",
        .serde = "Serde",
    };
};
