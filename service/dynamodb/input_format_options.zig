const CsvOptions = @import("csv_options.zig").CsvOptions;

/// The format options for the data that was imported into the target table.
/// There is one
/// value, CsvOption.
pub const InputFormatOptions = struct {
    /// The options for imported source files in CSV format. The values are
    /// Delimiter and
    /// HeaderList.
    csv: ?CsvOptions,
};
