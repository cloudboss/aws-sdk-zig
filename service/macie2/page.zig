const Range = @import("range.zig").Range;

/// Specifies the location of an occurrence of sensitive data in an Adobe
/// Portable Document Format file.
pub const Page = struct {
    /// Reserved for future use.
    line_range: ?Range = null,

    /// Reserved for future use.
    offset_range: ?Range = null,

    /// The page number of the page that contains the sensitive data.
    page_number: ?i64 = null,

    pub const json_field_names = .{
        .line_range = "lineRange",
        .offset_range = "offsetRange",
        .page_number = "pageNumber",
    };
};
