const CsvOutputOptions = @import("csv_output_options.zig").CsvOutputOptions;

/// Represents a set of options that define the structure of comma-separated
/// (CSV) job output.
pub const OutputFormatOptions = struct {
    /// Represents a set of options that define the structure of comma-separated
    /// value (CSV)
    /// job output.
    csv: ?CsvOutputOptions = null,

    pub const json_field_names = .{
        .csv = "Csv",
    };
};
