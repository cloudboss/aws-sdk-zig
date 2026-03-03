/// Processing options for the CSV file being imported.
pub const CsvOptions = struct {
    /// The delimiter used for separating items in the CSV file being imported.
    delimiter: ?[]const u8 = null,

    /// List of the headers used to specify a common header for all source CSV files
    /// being
    /// imported. If this field is specified then the first line of each CSV file is
    /// treated as
    /// data instead of the header. If this field is not specified the the first
    /// line of each
    /// CSV file is treated as the header.
    header_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
        .header_list = "HeaderList",
    };
};
