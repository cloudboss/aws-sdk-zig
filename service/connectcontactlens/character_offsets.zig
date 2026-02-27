/// For characters that were detected as issues, where they occur in the
/// transcript.
pub const CharacterOffsets = struct {
    /// The beginning of the issue.
    begin_offset_char: i32,

    /// The end of the issue.
    end_offset_char: i32,

    pub const json_field_names = .{
        .begin_offset_char = "BeginOffsetChar",
        .end_offset_char = "EndOffsetChar",
    };
};
