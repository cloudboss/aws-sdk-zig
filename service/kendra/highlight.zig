const HighlightType = @import("highlight_type.zig").HighlightType;

/// Provides information that you can use to highlight a search result so that
/// your users
/// can quickly identify terms in the response.
pub const Highlight = struct {
    /// The zero-based location in the response string where the highlight starts.
    begin_offset: i32,

    /// The zero-based location in the response string where the highlight ends.
    end_offset: i32,

    /// Indicates whether the response is the best response. True if this is the
    /// best
    /// response; otherwise, false.
    top_answer: bool = false,

    /// The highlight type.
    @"type": ?HighlightType,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .top_answer = "TopAnswer",
        .@"type" = "Type",
    };
};
