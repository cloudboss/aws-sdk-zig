const FileHeaderInfo = @import("file_header_info.zig").FileHeaderInfo;

/// Contains information about the comma-separated value (CSV) file to select
/// from.
pub const CSVInput = struct {
    /// A single character used to indicate that a row should be ignored when the
    /// character is
    /// present at the start of that row.
    comments: ?[]const u8 = null,

    /// A value used to separate individual fields from each other within a record.
    field_delimiter: ?[]const u8 = null,

    /// Describes the first line of input. Valid values are `None`,
    /// `Ignore`, and `Use`.
    file_header_info: ?FileHeaderInfo = null,

    /// A value used as an escape character where the field delimiter is part of the
    /// value.
    quote_character: ?[]const u8 = null,

    /// A single character used for escaping the quotation-mark character inside an
    /// already
    /// escaped value.
    quote_escape_character: ?[]const u8 = null,

    /// A value used to separate individual records from each other.
    record_delimiter: ?[]const u8 = null,

    pub const json_field_names = .{
        .comments = "Comments",
        .field_delimiter = "FieldDelimiter",
        .file_header_info = "FileHeaderInfo",
        .quote_character = "QuoteCharacter",
        .quote_escape_character = "QuoteEscapeCharacter",
        .record_delimiter = "RecordDelimiter",
    };
};
