/// Offset specification to describe highlighting of document excerpts for
/// rendering search
/// results and recommendations.
pub const Highlight = struct {
    /// The offset for the start of the highlight.
    begin_offset_inclusive: i32 = 0,

    /// The offset for the end of the highlight.
    end_offset_exclusive: i32 = 0,

    pub const json_field_names = .{
        .begin_offset_inclusive = "beginOffsetInclusive",
        .end_offset_exclusive = "endOffsetExclusive",
    };
};
