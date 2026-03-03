const Cell = @import("cell.zig").Cell;
const Range = @import("range.zig").Range;
const Page = @import("page.zig").Page;
const Record = @import("record.zig").Record;

/// The detected occurrences of sensitive data.
pub const Occurrences = struct {
    /// Occurrences of sensitive data detected in Microsoft Excel workbooks,
    /// comma-separated value (CSV) files, or tab-separated value (TSV) files.
    cells: ?[]const Cell = null,

    /// Occurrences of sensitive data detected in a non-binary text file or a
    /// Microsoft Word file. Non-binary text files include files such as HTML, XML,
    /// JSON, and TXT files.
    line_ranges: ?[]const Range = null,

    /// Occurrences of sensitive data detected in a binary text file.
    offset_ranges: ?[]const Range = null,

    /// Occurrences of sensitive data in an Adobe Portable Document Format (PDF)
    /// file.
    pages: ?[]const Page = null,

    /// Occurrences of sensitive data in an Apache Avro object container or an
    /// Apache Parquet file.
    records: ?[]const Record = null,

    pub const json_field_names = .{
        .cells = "Cells",
        .line_ranges = "LineRanges",
        .offset_ranges = "OffsetRanges",
        .pages = "Pages",
        .records = "Records",
    };
};
