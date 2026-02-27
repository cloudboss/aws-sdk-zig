/// Provides lexicon name and lexicon content in string format. For
/// more information, see [Pronunciation Lexicon
/// Specification (PLS) Version
/// 1.0](https://www.w3.org/TR/pronunciation-lexicon/).
pub const Lexicon = struct {
    /// Lexicon content in string format. The content of a lexicon must be
    /// in PLS format.
    content: ?[]const u8,

    /// Name of the lexicon.
    name: ?[]const u8,

    pub const json_field_names = .{
        .content = "Content",
        .name = "Name",
    };
};
