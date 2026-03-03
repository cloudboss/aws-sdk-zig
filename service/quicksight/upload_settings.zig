const FileFormat = @import("file_format.zig").FileFormat;
const TextQualifier = @import("text_qualifier.zig").TextQualifier;

/// Information about the format for a source file or files.
pub const UploadSettings = struct {
    /// Whether the file has a header row, or the files each have a header row.
    contains_header: ?bool = null,

    /// A custom cell address range for Excel files, specifying which cells to
    /// import from the spreadsheet.
    custom_cell_address_range: ?[]const u8 = null,

    /// The delimiter between values in the file.
    delimiter: ?[]const u8 = null,

    /// File format.
    format: ?FileFormat = null,

    /// A row number to start reading data from.
    start_from_row: ?i32 = null,

    /// Text qualifier.
    text_qualifier: ?TextQualifier = null,

    pub const json_field_names = .{
        .contains_header = "ContainsHeader",
        .custom_cell_address_range = "CustomCellAddressRange",
        .delimiter = "Delimiter",
        .format = "Format",
        .start_from_row = "StartFromRow",
        .text_qualifier = "TextQualifier",
    };
};
