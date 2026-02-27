/// Describes a key noun phrase.
pub const KeyPhrase = struct {
    /// The zero-based offset from the beginning of the source text to the first
    /// character in the
    /// key phrase.
    begin_offset: ?i32,

    /// The zero-based offset from the beginning of the source text to the last
    /// character in the
    /// key phrase.
    end_offset: ?i32,

    /// The level of confidence that Amazon Comprehend has in the accuracy of the
    /// detection.
    score: ?f32,

    /// The text of a key noun phrase.
    text: ?[]const u8,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .score = "Score",
        .text = "Text",
    };
};
