const Highlight = @import("highlight.zig").Highlight;

/// Indicates the starting and ending index of the country in the text query
/// that match the found title.
pub const CountryHighlights = struct {
    /// Indicates the starting and ending index of the country code in the text
    /// query that match the found title.
    code: ?[]const Highlight = null,

    /// Indicates the starting and ending index of the country code in the text
    /// query that match the found title.
    name: ?[]const Highlight = null,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
