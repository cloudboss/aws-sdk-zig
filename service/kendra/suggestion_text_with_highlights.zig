const SuggestionHighlight = @import("suggestion_highlight.zig").SuggestionHighlight;

/// Provides text and information about where to highlight the query suggestion
/// text.
pub const SuggestionTextWithHighlights = struct {
    /// The beginning and end of the query suggestion text that should be
    /// highlighted.
    highlights: ?[]const SuggestionHighlight,

    /// The query suggestion text to display to the user.
    text: ?[]const u8,

    pub const json_field_names = .{
        .highlights = "Highlights",
        .text = "Text",
    };
};
