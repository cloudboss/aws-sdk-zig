/// A delimited data format where the column separator can be a comma and the
/// record
/// separator is a newline character.
pub const CsvConfiguration = struct {
    /// Column separator can be one of comma (','), pipe ('|), semicolon (';'),
    /// tab('/t'), or
    /// blank space (' ').
    column_separator: ?[]const u8,

    /// Escape character can be one of
    escape_char: ?[]const u8,

    /// Can be blank space (' ').
    null_value: ?[]const u8,

    /// Can be single quote (') or double quote (").
    quote_char: ?[]const u8,

    /// Specifies to trim leading and trailing white space.
    trim_white_space: ?bool,

    pub const json_field_names = .{
        .column_separator = "ColumnSeparator",
        .escape_char = "EscapeChar",
        .null_value = "NullValue",
        .quote_char = "QuoteChar",
        .trim_white_space = "TrimWhiteSpace",
    };
};
