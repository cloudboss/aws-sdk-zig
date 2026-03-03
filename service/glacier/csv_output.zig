const QuoteFields = @import("quote_fields.zig").QuoteFields;

/// Contains information about the comma-separated value (CSV) file that the job
/// results
/// are stored in.
pub const CSVOutput = struct {
    /// A value used to separate individual fields from each other within a record.
    field_delimiter: ?[]const u8 = null,

    /// A value used as an escape character where the field delimiter is part of the
    /// value.
    quote_character: ?[]const u8 = null,

    /// A single character used for escaping the quotation-mark character inside an
    /// already
    /// escaped value.
    quote_escape_character: ?[]const u8 = null,

    /// A value that indicates whether all output fields should be contained within
    /// quotation
    /// marks.
    quote_fields: ?QuoteFields = null,

    /// A value used to separate individual records from each other.
    record_delimiter: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_delimiter = "FieldDelimiter",
        .quote_character = "QuoteCharacter",
        .quote_escape_character = "QuoteEscapeCharacter",
        .quote_fields = "QuoteFields",
        .record_delimiter = "RecordDelimiter",
    };
};
