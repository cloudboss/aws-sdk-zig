const PartOfSpeechTag = @import("part_of_speech_tag.zig").PartOfSpeechTag;

/// Represents a work in the input text that was recognized and assigned a part
/// of speech.
/// There is one syntax token record for each word in the source text.
pub const SyntaxToken = struct {
    /// The zero-based offset from the beginning of the source text to the first
    /// character in the
    /// word.
    begin_offset: ?i32,

    /// The zero-based offset from the beginning of the source text to the last
    /// character in the
    /// word.
    end_offset: ?i32,

    /// Provides the part of speech label and the confidence level that Amazon
    /// Comprehend has that
    /// the part of speech was correctly identified. For more information, see
    /// [Syntax](https://docs.aws.amazon.com/comprehend/latest/dg/how-syntax.html)
    /// in the Comprehend Developer Guide.
    part_of_speech: ?PartOfSpeechTag,

    /// The word that was recognized in the source text.
    text: ?[]const u8,

    /// A unique identifier for a token.
    token_id: ?i32,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .part_of_speech = "PartOfSpeech",
        .text = "Text",
        .token_id = "TokenId",
    };
};
