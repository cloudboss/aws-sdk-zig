/// Provides the name of the custom language model that was included in the
/// specified
/// transcription job.
///
/// Only use `ModelSettings` with the `LanguageModelName`
/// sub-parameter if you're **not** using automatic language
/// identification (``). If using
/// `LanguageIdSettings` in your request, this parameter contains a
/// `LanguageModelName` sub-parameter.
pub const ModelSettings = struct {
    /// The name of the custom language model you want to use when processing your
    /// transcription job. Note that custom language model names are case sensitive.
    ///
    /// The language of the specified custom language model must match the language
    /// code that
    /// you specify in your transcription request. If the languages do not match,
    /// the custom
    /// language model isn't applied. There are no errors or warnings associated
    /// with a language
    /// mismatch.
    language_model_name: ?[]const u8,

    pub const json_field_names = .{
        .language_model_name = "LanguageModelName",
    };
};
