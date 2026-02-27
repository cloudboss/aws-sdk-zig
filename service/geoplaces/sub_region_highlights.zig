const Highlight = @import("highlight.zig").Highlight;

/// Indicates the starting and ending index of the sub-region in the text query
/// that match the found title.
pub const SubRegionHighlights = struct {
    /// Indicates the starting and ending index of the sub-region in the text query
    /// that match the found title.
    code: ?[]const Highlight,

    /// Indicates the starting and ending index of the name in the text query that
    /// match the found title.
    name: ?[]const Highlight,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
