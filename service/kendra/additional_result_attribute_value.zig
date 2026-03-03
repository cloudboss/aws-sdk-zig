const TextWithHighlights = @import("text_with_highlights.zig").TextWithHighlights;

/// An attribute returned with a document from a search.
pub const AdditionalResultAttributeValue = struct {
    /// The text associated with the attribute and information about the highlight
    /// to apply to
    /// the text.
    text_with_highlights_value: ?TextWithHighlights = null,

    pub const json_field_names = .{
        .text_with_highlights_value = "TextWithHighlightsValue",
    };
};
