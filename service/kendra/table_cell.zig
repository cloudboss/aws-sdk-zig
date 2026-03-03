/// Provides information about a table cell in a table excerpt.
pub const TableCell = struct {
    /// `TRUE` means that the table cell should be treated as a header.
    header: bool = false,

    /// `TRUE` means that the table cell has a high enough confidence and is
    /// relevant to the query, so the value or content should be highlighted.
    highlighted: bool = false,

    /// `TRUE` if the response of the table cell is the top answer. This is the
    /// cell value or content with the highest confidence score or is the most
    /// relevant to the
    /// query.
    top_answer: bool = false,

    /// The actual value or content within a table cell. A table cell could contain
    /// a date
    /// value of a year, or a string value of text, for example.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .header = "Header",
        .highlighted = "Highlighted",
        .top_answer = "TopAnswer",
        .value = "Value",
    };
};
