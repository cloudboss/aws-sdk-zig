const ContentType = @import("content_type.zig").ContentType;
const CallAnalyticsLanguageCode = @import("call_analytics_language_code.zig").CallAnalyticsLanguageCode;
const PartialResultsStability = @import("partial_results_stability.zig").PartialResultsStability;
const PostCallAnalyticsSettings = @import("post_call_analytics_settings.zig").PostCallAnalyticsSettings;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;

/// A structure that contains the configuration settings for an Amazon
/// Transcribe call
/// analytics processor.
pub const AmazonTranscribeCallAnalyticsProcessorConfiguration = struct {
    /// By default, all `CategoryEvents` are sent to the insights target. If this
    /// parameter is specified, only included categories are sent to the insights
    /// target.
    call_analytics_stream_categories: ?[]const []const u8 = null,

    /// Labels all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content identification is performed at the segment level; PII specified in
    /// `PiiEntityTypes` is flagged upon complete transcription of an audio segment.
    ///
    /// You can’t set `ContentIdentificationType` and `ContentRedactionType` in the
    /// same request. If you do, your request returns a `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html)
    /// in the *Amazon Transcribe Developer Guide*.
    content_identification_type: ?ContentType = null,

    /// Redacts all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content redaction is performed at the segment level; PII specified in
    /// `PiiEntityTypes` is redacted upon complete transcription of an audio
    /// segment.
    ///
    /// You can’t set `ContentRedactionType` and `ContentIdentificationType` in the
    /// same request. If you do, your request returns a `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html)
    /// in the *Amazon Transcribe Developer Guide*.
    content_redaction_type: ?ContentType = null,

    /// Enables partial result stabilization for your transcription. Partial result
    /// stabilization can reduce latency in your output, but may impact accuracy.
    /// For more information, see [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization)
    /// in the *Amazon Transcribe Developer Guide*.
    enable_partial_results_stabilization: bool = false,

    /// If true, `UtteranceEvents` with `IsPartial: true` are filtered out of the
    /// insights target.
    filter_partial_results: bool = false,

    /// The language code in the configuration.
    language_code: CallAnalyticsLanguageCode,

    /// Specifies the name of the custom language model to use when processing a
    /// transcription.
    /// Note that language model names are case sensitive.
    ///
    /// The language of the specified language model must match the language code
    /// specified
    /// in the transcription request. If the languages don't match, the custom
    /// language model isn't
    /// applied. Language mismatches don't generate errors or warnings.
    ///
    /// For more information, see [Custom language
    /// models](https://docs.aws.amazon.com/transcribe/latest/dg/custom-language-models.html) in the *Amazon Transcribe Developer Guide*.
    language_model_name: ?[]const u8 = null,

    /// Specifies the level of stability to use when you enable partial results
    /// stabilization
    /// (`EnablePartialResultsStabilization`).
    ///
    /// Low stability provides the highest accuracy. High stability transcribes
    /// faster, but with slightly lower accuracy.
    ///
    /// For more information, see [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization)
    /// in the *Amazon Transcribe Developer Guide*.
    partial_results_stability: ?PartialResultsStability = null,

    /// Specifies the types of personally identifiable information (PII) to redact
    /// from a transcript. You can include as many types as you'd like, or you can
    /// select `ALL`.
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
    /// Length Constraints: Minimum length of 1. Maximum length of 300.
    pii_entity_types: ?[]const u8 = null,

    /// The settings for a post-call analysis task in an analytics configuration.
    post_call_analytics_settings: ?PostCallAnalyticsSettings = null,

    /// Specifies how to apply a vocabulary filter to a transcript.
    ///
    /// To replace words with *******, choose `mask`.
    ///
    /// To delete words, choose `remove`.
    ///
    /// To flag words without changing them, choose `tag`.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// Specifies the name of the custom vocabulary filter to use when processing a
    /// transcription. Note that vocabulary filter names are case sensitive.
    ///
    /// If the language of the specified custom vocabulary filter doesn't match the
    /// language identified in your media, the vocabulary filter is not applied to
    /// your transcription.
    ///
    /// For more information, see [Using vocabulary filtering with unwanted
    /// words](https://docs.aws.amazon.com/transcribe/latest/dg/vocabulary-filtering.html)
    /// in the *Amazon Transcribe Developer Guide*.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 200.
    vocabulary_filter_name: ?[]const u8 = null,

    /// Specifies the name of the custom vocabulary to use when processing a
    /// transcription. Note
    /// that vocabulary names are case sensitive.
    ///
    /// If the language of the specified custom vocabulary doesn't match the
    /// language identified in your media, the custom vocabulary is not applied to
    /// your transcription.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html) in the *Amazon Transcribe Developer Guide*.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 200.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .call_analytics_stream_categories = "CallAnalyticsStreamCategories",
        .content_identification_type = "ContentIdentificationType",
        .content_redaction_type = "ContentRedactionType",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .filter_partial_results = "FilterPartialResults",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .post_call_analytics_settings = "PostCallAnalyticsSettings",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
