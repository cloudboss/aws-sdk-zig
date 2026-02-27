/// Provides the location, using character count, in your transcript where a
/// match is identified. For example,
/// the location of an issue or a category match within a segment.
pub const CharacterOffsets = struct {
    /// Provides the character count of the first character where a match is
    /// identified. For example, the first
    /// character associated with an issue or a category match in a segment
    /// transcript.
    begin: ?i32,

    /// Provides the character count of the last character where a match is
    /// identified. For example, the last
    /// character associated with an issue or a category match in a segment
    /// transcript.
    end: ?i32,

    pub const json_field_names = .{
        .begin = "Begin",
        .end = "End",
    };
};
