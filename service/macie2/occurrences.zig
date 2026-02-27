const Cell = @import("cell.zig").Cell;
const Range = @import("range.zig").Range;
const Page = @import("page.zig").Page;
const Record = @import("record.zig").Record;

/// Specifies the location of 1-15 occurrences of sensitive data that was
/// detected by a managed data identifier or a custom data identifier and
/// produced a sensitive data finding.
pub const Occurrences = struct {
    /// An array of objects, one for each occurrence of sensitive data in a
    /// Microsoft Excel workbook, CSV file, or TSV file. This value is null for all
    /// other types of files.
    ///
    /// Each Cell object specifies a cell or field that contains the sensitive data.
    cells: ?[]const Cell,

    /// An array of objects, one for each occurrence of sensitive data in an email
    /// message or a non-binary text file such as an HTML, TXT, or XML file. Each
    /// Range object specifies a line or inclusive range of lines that contains the
    /// sensitive data, and the position of the data on the specified line or lines.
    ///
    /// This value is often null for file types that are supported by Cell, Page, or
    /// Record objects. Exceptions are the location of sensitive data in:
    /// unstructured sections of an otherwise structured file, such as a comment in
    /// a file; a malformed file that Amazon Macie analyzes as plain text; and, a
    /// CSV or TSV file that has any column names that contain sensitive data.
    line_ranges: ?[]const Range,

    /// Reserved for future use.
    offset_ranges: ?[]const Range,

    /// An array of objects, one for each occurrence of sensitive data in an Adobe
    /// Portable Document Format file. This value is null for all other types of
    /// files.
    ///
    /// Each Page object specifies a page that contains the sensitive data.
    pages: ?[]const Page,

    /// An array of objects, one for each occurrence of sensitive data in an Apache
    /// Avro object container, Apache Parquet file, JSON file, or JSON Lines file.
    /// This value is null for all other types of files.
    ///
    /// For an Avro object container or Parquet file, each Record object specifies a
    /// record index and the path to a field in a record that contains the sensitive
    /// data. For a JSON or JSON Lines file, each Record object specifies the path
    /// to a field or array that contains the sensitive data. For a JSON Lines file,
    /// it also specifies the index of the line that contains the data.
    records: ?[]const Record,

    pub const json_field_names = .{
        .cells = "cells",
        .line_ranges = "lineRanges",
        .offset_ranges = "offsetRanges",
        .pages = "pages",
        .records = "records",
    };
};
