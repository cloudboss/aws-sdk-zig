/// Returns the code for the dominant language in the input text and the level
/// of
/// confidence that Amazon Comprehend has in the accuracy of the detection.
pub const DominantLanguage = struct {
    /// The RFC 5646 language code for the dominant language. For more information
    /// about RFC
    /// 5646, see [Tags for Identifying
    /// Languages](https://tools.ietf.org/html/rfc5646) on the *IETF Tools* web
    /// site.
    language_code: ?[]const u8 = null,

    /// The level of confidence that Amazon Comprehend has in the accuracy of the
    /// detection.
    score: ?f32 = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .score = "Score",
    };
};
