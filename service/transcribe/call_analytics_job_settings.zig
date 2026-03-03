const aws = @import("aws");

const ContentRedaction = @import("content_redaction.zig").ContentRedaction;
const LanguageIdSettings = @import("language_id_settings.zig").LanguageIdSettings;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Summarization = @import("summarization.zig").Summarization;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;

/// Provides additional optional settings for your request, including content
/// redaction,
/// automatic language identification; allows you to apply custom language
/// models, custom
/// vocabulary filters, and custom vocabularies.
pub const CallAnalyticsJobSettings = struct {
    content_redaction: ?ContentRedaction = null,

    /// If using automatic language identification in your request and you want to
    /// apply a
    /// custom language model, a custom vocabulary, or a custom vocabulary filter,
    /// include
    /// `LanguageIdSettings` with the relevant sub-parameters
    /// (`VocabularyName`, `LanguageModelName`, and
    /// `VocabularyFilterName`).
    ///
    /// `LanguageIdSettings` supports two to five language codes. Each language
    /// code you include can have an associated custom language model, custom
    /// vocabulary, and
    /// custom vocabulary filter. The language codes that you specify must match the
    /// languages
    /// of the associated custom language models, custom vocabularies, and custom
    /// vocabulary
    /// filters.
    ///
    /// It's recommended that you include `LanguageOptions` when using
    /// `LanguageIdSettings` to ensure that the correct language dialect is
    /// identified. For example, if you specify a custom vocabulary that is in
    /// `en-US` but Amazon Transcribe determines that the language spoken in
    /// your media is `en-AU`, your custom vocabulary *is not*
    /// applied to your transcription. If you include `LanguageOptions` and include
    /// `en-US` as the only English language dialect, your custom vocabulary
    /// *is* applied to your transcription.
    ///
    /// If you want to include a custom language model, custom vocabulary, or custom
    /// vocabulary filter with your request but **do not** want to
    /// use automatic language identification, use instead the `` parameter with the
    /// `LanguageModelName`, `VocabularyName`, or
    /// `VocabularyFilterName` sub-parameters.
    ///
    /// For a list of languages supported with Call Analytics, refer to [Supported
    /// languages and
    /// language-specific
    /// features](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html).
    language_id_settings: ?[]const aws.map.MapEntry(LanguageIdSettings) = null,

    /// The name of the custom language model you want to use when processing your
    /// Call
    /// Analytics job. Note that custom language model names are case sensitive.
    ///
    /// The language of the specified custom language model must match the language
    /// code that
    /// you specify in your transcription request. If the languages do not match,
    /// the custom
    /// language model isn't applied. There are no errors or warnings associated
    /// with a language
    /// mismatch.
    language_model_name: ?[]const u8 = null,

    /// You can specify two or more language codes that represent the languages you
    /// think may
    /// be present in your media. Including more than five is not recommended. If
    /// you're unsure
    /// what languages are present, do not include this parameter.
    ///
    /// Including language options can improve the accuracy of language
    /// identification.
    ///
    /// For a list of languages supported with Call Analytics, refer to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    ///
    /// To transcribe speech in Modern Standard Arabic (`ar-SA`) in Amazon Web
    /// Services GovCloud (US) (US-West, us-gov-west-1), Amazon Web Services
    /// GovCloud (US) (US-East, us-gov-east-1), Canada (Calgary) ca-west-1 and
    /// Africa (Cape Town) af-south-1, your media file
    /// must be encoded at a sample rate of 16,000 Hz or higher.
    language_options: ?[]const LanguageCode = null,

    /// Contains `GenerateAbstractiveSummary`, which is a required parameter if you
    /// want to enable Generative call summarization in your Call Analytics request.
    summarization: ?Summarization = null,

    /// Specify how you want your custom vocabulary filter applied to your
    /// transcript.
    ///
    /// To replace words with `***`, choose `mask`.
    ///
    /// To delete words, choose `remove`.
    ///
    /// To flag words without changing them, choose `tag`.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// The name of the custom vocabulary filter you want to include in your Call
    /// Analytics
    /// transcription request. Custom vocabulary filter names are case sensitive.
    ///
    /// Note that if you include `VocabularyFilterName` in your request, you must
    /// also include `VocabularyFilterMethod`.
    vocabulary_filter_name: ?[]const u8 = null,

    /// The name of the custom vocabulary you want to include in your Call Analytics
    /// transcription request. Custom vocabulary names are case sensitive.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_redaction = "ContentRedaction",
        .language_id_settings = "LanguageIdSettings",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .summarization = "Summarization",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
