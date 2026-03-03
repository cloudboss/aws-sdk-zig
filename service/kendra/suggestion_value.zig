const SuggestionTextWithHighlights = @import("suggestion_text_with_highlights.zig").SuggestionTextWithHighlights;

/// The `SuggestionTextWithHighlights` structure information.
pub const SuggestionValue = struct {
    /// The `SuggestionTextWithHighlights` structure that contains
    /// the query suggestion text and highlights.
    text: ?SuggestionTextWithHighlights = null,

    pub const json_field_names = .{
        .text = "Text",
    };
};
