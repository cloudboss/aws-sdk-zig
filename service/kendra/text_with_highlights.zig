const Highlight = @import("highlight.zig").Highlight;

/// Provides text and information about where to highlight the text.
pub const TextWithHighlights = struct {
    /// The beginning and end of the text that should be highlighted.
    highlights: ?[]const Highlight,

    /// The text to display to the user.
    text: ?[]const u8,

    pub const json_field_names = .{
        .highlights = "Highlights",
        .text = "Text",
    };
};
