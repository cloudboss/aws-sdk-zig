const Range = @import("range.zig").Range;

/// Specifies the location of an occurrence of sensitive data in an Adobe
/// Portable Document Format file.
pub const Page = struct {
    /// Reserved for future use.
    line_range: ?Range,

    /// Reserved for future use.
    offset_range: ?Range,

    /// The page number of the page that contains the sensitive data.
    page_number: ?i64,

    pub const json_field_names = .{
        .line_range = "lineRange",
        .offset_range = "offsetRange",
        .page_number = "pageNumber",
    };
};
