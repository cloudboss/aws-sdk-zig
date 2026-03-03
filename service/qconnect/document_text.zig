const Highlight = @import("highlight.zig").Highlight;

/// The text of the document.
pub const DocumentText = struct {
    /// Highlights in the document text.
    highlights: ?[]const Highlight = null,

    /// Text in the document.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .highlights = "highlights",
        .text = "text",
    };
};
