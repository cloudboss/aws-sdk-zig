const Range = @import("range.zig").Range;

/// An occurrence of sensitive data in an Adobe Portable Document Format (PDF)
/// file.
pub const Page = struct {
    /// An occurrence of sensitive data detected in a non-binary text file or a
    /// Microsoft Word file. Non-binary text files include files such as HTML, XML,
    /// JSON, and TXT files.
    line_range: ?Range,

    /// An occurrence of sensitive data detected in a binary text file.
    offset_range: ?Range,

    /// The page number of the page that contains the sensitive data.
    page_number: ?i64,

    pub const json_field_names = .{
        .line_range = "LineRange",
        .offset_range = "OffsetRange",
        .page_number = "PageNumber",
    };
};
