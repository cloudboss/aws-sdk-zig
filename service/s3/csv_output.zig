const QuoteFields = @import("quote_fields.zig").QuoteFields;

/// Describes how uncompressed comma-separated values (CSV)-formatted results
/// are formatted.
pub const CSVOutput = struct {
    /// The value used to separate individual fields in a record. You can specify an
    /// arbitrary
    /// delimiter.
    field_delimiter: ?[]const u8,

    /// A single character used for escaping when the field delimiter is part of the
    /// value. For example, if
    /// the value is `a, b`, Amazon S3 wraps this field value in quotation marks, as
    /// follows: `" a ,
    /// b "`.
    quote_character: ?[]const u8,

    /// The single character used for escaping the quote character inside an already
    /// escaped value.
    quote_escape_character: ?[]const u8,

    /// Indicates whether to use quotation marks around output fields.
    ///
    /// * `ALWAYS`: Always use quotation marks for output fields.
    ///
    /// * `ASNEEDED`: Use quotation marks for output fields when needed.
    quote_fields: ?QuoteFields,

    /// A single character used to separate individual records in the output.
    /// Instead of the default value,
    /// you can specify an arbitrary delimiter.
    record_delimiter: ?[]const u8,
};
