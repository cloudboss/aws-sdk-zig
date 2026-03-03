const PartOfSpeechTagType = @import("part_of_speech_tag_type.zig").PartOfSpeechTagType;

/// Identifies the part of speech represented by the token and gives the
/// confidence that
/// Amazon Comprehend has that the part of speech was correctly identified. For
/// more information
/// about the parts of speech that Amazon Comprehend can identify, see
/// [Syntax](https://docs.aws.amazon.com/comprehend/latest/dg/how-syntax.html)
/// in the Comprehend Developer Guide.
pub const PartOfSpeechTag = struct {
    /// The confidence that Amazon Comprehend has that the part of speech was
    /// correctly
    /// identified.
    score: ?f32 = null,

    /// Identifies the part of speech that the token represents.
    tag: ?PartOfSpeechTagType = null,

    pub const json_field_names = .{
        .score = "Score",
        .tag = "Tag",
    };
};
