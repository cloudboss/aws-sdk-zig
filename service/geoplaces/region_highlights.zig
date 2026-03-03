const Highlight = @import("highlight.zig").Highlight;

/// Indicates the starting and ending index of the region in the text query that
/// match the found title.
pub const RegionHighlights = struct {
    /// Indicates the starting and ending index of the region in the text query that
    /// match the found title.
    code: ?[]const Highlight = null,

    /// Indicates the starting and ending index of the region name in the text query
    /// that match the found title.
    name: ?[]const Highlight = null,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
