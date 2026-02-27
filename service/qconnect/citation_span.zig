/// Contains information about where the text with a citation begins and ends in
/// the generated output.
pub const CitationSpan = struct {
    /// Where the text with a citation starts in the generated output.
    begin_offset_inclusive: i32 = 0,

    /// Where the text with a citation ends in the generated output.
    end_offset_exclusive: i32 = 0,

    pub const json_field_names = .{
        .begin_offset_inclusive = "beginOffsetInclusive",
        .end_offset_exclusive = "endOffsetExclusive",
    };
};
