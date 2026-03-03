/// Read options for an annotation import job.
pub const ReadOptions = struct {
    /// The file's comment character.
    comment: ?[]const u8 = null,

    /// The file's encoding.
    encoding: ?[]const u8 = null,

    /// A character for escaping quotes in the file.
    escape: ?[]const u8 = null,

    /// Whether quotes need to be escaped in the file.
    escape_quotes: bool = false,

    /// Whether the file has a header row.
    header: bool = false,

    /// A line separator for the file.
    line_sep: ?[]const u8 = null,

    /// The file's quote character.
    quote: ?[]const u8 = null,

    /// Whether all values need to be quoted, or just those that contain quotes.
    quote_all: bool = false,

    /// The file's field separator.
    sep: ?[]const u8 = null,

    pub const json_field_names = .{
        .comment = "comment",
        .encoding = "encoding",
        .escape = "escape",
        .escape_quotes = "escapeQuotes",
        .header = "header",
        .line_sep = "lineSep",
        .quote = "quote",
        .quote_all = "quoteAll",
        .sep = "sep",
    };
};
