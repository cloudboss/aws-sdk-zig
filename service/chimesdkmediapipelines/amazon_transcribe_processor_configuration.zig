const ContentType = @import("content_type.zig").ContentType;
const CallAnalyticsLanguageCode = @import("call_analytics_language_code.zig").CallAnalyticsLanguageCode;
const PartialResultsStability = @import("partial_results_stability.zig").PartialResultsStability;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;

/// A structure that contains the configuration settings for an Amazon
/// Transcribe processor.
///
/// Calls to this API must include a `LanguageCode`, `IdentifyLanguage`, or
/// `IdentifyMultipleLanguages` parameter.
/// If you include more than one of those parameters, your transcription job
/// fails.
pub const AmazonTranscribeProcessorConfiguration = struct {
    /// Labels all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content identification is performed at the segment level; PII specified in
    /// `PiiEntityTypes` is flagged upon complete transcription of an audio
    /// segment.
    ///
    /// You can’t set `ContentIdentificationType` and
    /// `ContentRedactionType` in the same request. If you set both, your request
    /// returns a `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html)
    /// in the *Amazon Transcribe Developer Guide*.
    content_identification_type: ?ContentType,

    /// Redacts all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content redaction is performed at the segment level; PII specified in
    /// PiiEntityTypes is redacted upon complete transcription of an audio segment.
    ///
    /// You can’t set ContentRedactionType and ContentIdentificationType in the same
    /// request. If you set both, your request returns a `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html)
    /// in the *Amazon Transcribe Developer Guide*.
    content_redaction_type: ?ContentType,

    /// Enables partial result stabilization for your transcription. Partial result
    /// stabilization can reduce latency in your output, but may impact accuracy.
    ///
    /// For more information, see [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization)
    /// in the *Amazon Transcribe Developer Guide*.
    enable_partial_results_stabilization: bool = false,

    /// If true, `TranscriptEvents` with `IsPartial: true` are filtered out of the
    /// insights target.
    filter_partial_results: bool = false,

    /// Turns language identification on or off.
    identify_language: bool = false,

    /// Turns language identification on or off for multiple languages.
    ///
    /// Calls to this API must include a `LanguageCode`, `IdentifyLanguage`, or
    /// `IdentifyMultipleLanguages` parameter.
    /// If you include more than one of those parameters, your transcription job
    /// fails.
    identify_multiple_languages: bool = false,

    /// The language code that represents the language spoken in your audio.
    ///
    /// If you're unsure of the language spoken in your audio, consider using
    /// `IdentifyLanguage` to enable automatic language identification.
    ///
    /// For a list of languages that real-time Call Analytics supports, see the
    /// [Supported languages
    /// table](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html)
    /// in the *Amazon Transcribe Developer Guide*.
    language_code: ?CallAnalyticsLanguageCode,

    /// The name of the custom language model that you want to use when processing
    /// your
    /// transcription. Note that language model names are case sensitive.
    ///
    /// The language of the specified language model must match the language code
    /// you specify in your transcription request. If the languages don't match, the
    /// custom language model isn't applied.
    /// There are no errors or warnings associated with a language mismatch.
    ///
    /// For more information, see [Custom language
    /// models](https://docs.aws.amazon.com/transcribe/latest/dg/custom-language-models.html) in the *Amazon Transcribe Developer Guide*.
    language_model_name: ?[]const u8,

    /// The language options for the transcription, such as automatic language
    /// detection.
    language_options: ?[]const u8,

    /// The level of stability to use when you enable partial results stabilization
    /// (`EnablePartialResultsStabilization`).
    ///
    /// Low stability provides the highest accuracy. High stability transcribes
    /// faster, but with slightly lower accuracy.
    ///
    /// For more information, see [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization)
    /// in the *Amazon Transcribe Developer Guide*.
    partial_results_stability: ?PartialResultsStability,

    /// The types of personally identifiable information (PII) to redact from a
    /// transcript. You
    /// can include as many types as you'd like, or you can select `ALL`.
    ///
    /// To include `PiiEntityTypes` in your Call Analytics request, you must also
    /// include `ContentIdentificationType` or `ContentRedactionType`, but you can't
    /// include both.
    ///
    /// Values must be comma-separated and can include: `ADDRESS`,
    /// `BANK_ACCOUNT_NUMBER`, `BANK_ROUTING`, `CREDIT_DEBIT_CVV`,
    /// `CREDIT_DEBIT_EXPIRY`, `CREDIT_DEBIT_NUMBER`, `EMAIL`,
    /// `NAME`, `PHONE`, `PIN`, `SSN`, or `ALL`.
    ///
    /// If you leave this parameter empty, the default behavior is equivalent to
    /// `ALL`.
    pii_entity_types: ?[]const u8,

    /// The preferred language for the transcription.
    preferred_language: ?CallAnalyticsLanguageCode,

    /// Enables speaker partitioning (diarization) in your transcription output.
    /// Speaker partitioning labels the speech from individual speakers in your
    /// media file.
    ///
    /// For more information, see [Partitioning speakers
    /// (diarization)](https://docs.aws.amazon.com/transcribe/latest/dg/diarization.html) in the *Amazon Transcribe Developer Guide*.
    show_speaker_label: bool = false,

    /// The vocabulary filtering method used in your Call Analytics transcription.
    vocabulary_filter_method: ?VocabularyFilterMethod,

    /// The name of the custom vocabulary filter that you specified in your Call
    /// Analytics
    /// request.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 200.
    vocabulary_filter_name: ?[]const u8,

    /// The names of the custom vocabulary filter or filters using during
    /// transcription.
    vocabulary_filter_names: ?[]const u8,

    /// The name of the custom vocabulary that you specified in your Call Analytics
    /// request.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 200.
    vocabulary_name: ?[]const u8,

    /// The names of the custom vocabulary or vocabularies used during
    /// transcription.
    vocabulary_names: ?[]const u8,

    pub const json_field_names = .{
        .content_identification_type = "ContentIdentificationType",
        .content_redaction_type = "ContentRedactionType",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .filter_partial_results = "FilterPartialResults",
        .identify_language = "IdentifyLanguage",
        .identify_multiple_languages = "IdentifyMultipleLanguages",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .preferred_language = "PreferredLanguage",
        .show_speaker_label = "ShowSpeakerLabel",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_filter_names = "VocabularyFilterNames",
        .vocabulary_name = "VocabularyName",
        .vocabulary_names = "VocabularyNames",
    };
};
