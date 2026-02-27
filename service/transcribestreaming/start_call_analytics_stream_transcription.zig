const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AudioStream = @import("audio_stream.zig").AudioStream;
const ContentIdentificationType = @import("content_identification_type.zig").ContentIdentificationType;
const ContentRedactionType = @import("content_redaction_type.zig").ContentRedactionType;
const CallAnalyticsLanguageCode = @import("call_analytics_language_code.zig").CallAnalyticsLanguageCode;
const MediaEncoding = @import("media_encoding.zig").MediaEncoding;
const PartialResultsStability = @import("partial_results_stability.zig").PartialResultsStability;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;
const CallAnalyticsTranscriptResultStream = @import("call_analytics_transcript_result_stream.zig").CallAnalyticsTranscriptResultStream;

pub const StartCallAnalyticsStreamTranscriptionInput = struct {
    /// An encoded stream of audio blobs. Audio streams are encoded as either HTTP/2
    /// or WebSocket
    /// data frames.
    ///
    /// For more information, see [Transcribing streaming
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html).
    audio_stream: AudioStream,

    /// Labels all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content identification is performed at the segment level; PII specified in
    /// `PiiEntityTypes` is flagged upon complete transcription of an audio segment.
    /// If you don't
    /// include `PiiEntityTypes` in your request, all PII is identified.
    ///
    /// You can’t set `ContentIdentificationType` and `ContentRedactionType`
    /// in the same request. If you set both, your request returns a
    /// `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html).
    content_identification_type: ?ContentIdentificationType = null,

    /// Redacts all personally identifiable information (PII) identified in your
    /// transcript.
    ///
    /// Content redaction is performed at the segment level; PII specified in
    /// `PiiEntityTypes` is redacted upon complete transcription of an audio
    /// segment. If you don't
    /// include `PiiEntityTypes` in your request, all PII is redacted.
    ///
    /// You can’t set `ContentRedactionType` and `ContentIdentificationType`
    /// in the same request. If you set both, your request returns a
    /// `BadRequestException`.
    ///
    /// For more information, see [Redacting or identifying personally identifiable
    /// information](https://docs.aws.amazon.com/transcribe/latest/dg/pii-redaction.html).
    content_redaction_type: ?ContentRedactionType = null,

    /// Enables partial result stabilization for your transcription. Partial result
    /// stabilization can reduce
    /// latency in your output, but may impact accuracy. For more information, see
    /// [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization).
    enable_partial_results_stabilization: bool = false,

    /// Enables automatic language identification for your Call Analytics
    /// transcription.
    ///
    /// If you include `IdentifyLanguage`, you must include a list of
    /// language codes, using `LanguageOptions`, that you think may be present in
    /// your audio stream. You must provide a minimum of two language selections.
    ///
    /// You can also include a preferred language using `PreferredLanguage`. Adding
    /// a
    /// preferred language can help Amazon Transcribe identify the language faster
    /// than if you omit this
    /// parameter.
    ///
    /// Note that you must include either `LanguageCode` or
    /// `IdentifyLanguage` in your request. If you include both parameters, your
    /// transcription job
    /// fails.
    identify_language: bool = false,

    /// Specify the language code that represents the language spoken in your audio.
    ///
    /// For a list of languages supported with real-time Call Analytics, refer to
    /// the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    language_code: ?CallAnalyticsLanguageCode = null,

    /// Specify the name of the custom language model that you want to use when
    /// processing your
    /// transcription. Note that language model names are case sensitive.
    ///
    /// The language of the specified language model must match the language code
    /// you specify
    /// in your transcription request. If the languages don't match, the custom
    /// language model isn't applied.
    /// There are no errors or warnings associated with a language mismatch.
    ///
    /// For more information, see [Custom language
    /// models](https://docs.aws.amazon.com/transcribe/latest/dg/custom-language-models.html).
    language_model_name: ?[]const u8 = null,

    /// Specify two or more language codes that represent the languages you think
    /// may be present
    /// in your media.
    ///
    /// Including language options can improve the accuracy of language
    /// identification.
    ///
    /// If you include `LanguageOptions` in your request, you must also include
    /// `IdentifyLanguage`.
    ///
    /// For a list of languages supported with Call Analytics streaming, refer to
    /// the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    ///
    /// You can only include one language dialect per language per stream. For
    /// example, you
    /// cannot include `en-US` and `en-AU` in the same request.
    language_options: ?[]const u8 = null,

    /// Specify the encoding of your input audio. Supported formats are:
    ///
    /// * FLAC
    ///
    /// * OPUS-encoded audio in an Ogg container
    ///
    /// * PCM (only signed 16-bit little-endian audio formats, which does not
    ///   include WAV)
    ///
    /// For more information, see [Media
    /// formats](https://docs.aws.amazon.com/transcribe/latest/dg/how-input.html#how-input-audio).
    media_encoding: MediaEncoding,

    /// The sample rate of the input audio (in hertz). Low-quality audio, such as
    /// telephone audio,
    /// is typically around 8,000 Hz. High-quality audio typically ranges from
    /// 16,000 Hz to 48,000 Hz.
    /// Note that the sample rate you specify must match that of your audio.
    media_sample_rate_hertz: i32,

    /// Specify the level of stability to use when you enable partial results
    /// stabilization
    /// (`EnablePartialResultsStabilization`).
    ///
    /// Low stability provides the highest accuracy. High stability transcribes
    /// faster, but with slightly
    /// lower accuracy.
    ///
    /// For more information, see [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization).
    partial_results_stability: ?PartialResultsStability = null,

    /// Specify which types of personally identifiable information (PII) you want to
    /// redact in your
    /// transcript. You can include as many types as you'd like, or you can select
    /// `ALL`.
    ///
    /// Values must be comma-separated and can include: `ADDRESS`,
    /// `BANK_ACCOUNT_NUMBER`, `BANK_ROUTING`,
    /// `CREDIT_DEBIT_CVV`, `CREDIT_DEBIT_EXPIRY`,
    /// `CREDIT_DEBIT_NUMBER`, `EMAIL`,
    /// `NAME`, `PHONE`, `PIN`,
    /// `SSN`, or `ALL`.
    ///
    /// Note that if you include `PiiEntityTypes` in your request, you must also
    /// include
    /// `ContentIdentificationType` or `ContentRedactionType`.
    ///
    /// If you include `ContentRedactionType` or
    /// `ContentIdentificationType` in your request, but do not include
    /// `PiiEntityTypes`, all PII is redacted or identified.
    pii_entity_types: ?[]const u8 = null,

    /// Specify a preferred language from the subset of languages codes you
    /// specified in
    /// `LanguageOptions`.
    ///
    /// You can only use this parameter if you've included `IdentifyLanguage` and
    /// `LanguageOptions` in your request.
    preferred_language: ?CallAnalyticsLanguageCode = null,

    /// Specify a name for your Call Analytics transcription session. If you don't
    /// include this parameter
    /// in your request, Amazon Transcribe generates an ID and returns it in the
    /// response.
    session_id: ?[]const u8 = null,

    /// Specify how you want your vocabulary filter applied to your transcript.
    ///
    /// To replace words with `***`, choose `mask`.
    ///
    /// To delete words, choose `remove`.
    ///
    /// To flag words without changing them, choose `tag`.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// Specify the name of the custom vocabulary filter that you want to use when
    /// processing your
    /// transcription. Note that vocabulary filter names are case sensitive.
    ///
    /// If the language of the specified custom vocabulary filter doesn't match the
    /// language identified in
    /// your media, the vocabulary filter is not applied to your transcription.
    ///
    /// For more information, see [Using vocabulary filtering with unwanted
    /// words](https://docs.aws.amazon.com/transcribe/latest/dg/vocabulary-filtering.html).
    vocabulary_filter_name: ?[]const u8 = null,

    /// Specify the names of the custom vocabulary filters that you want to use when
    /// processing
    /// your Call Analytics transcription. Note that vocabulary filter names are
    /// case sensitive.
    ///
    /// These filters serve to customize the transcript output.
    ///
    /// This parameter is only intended for use **with**
    /// the `IdentifyLanguage` parameter. If you're **not**
    /// including `IdentifyLanguage` in your request and want to use a custom
    /// vocabulary filter
    /// with your transcription, use the `VocabularyFilterName` parameter instead.
    ///
    /// For more information, see [Using vocabulary filtering with unwanted
    /// words](https://docs.aws.amazon.com/transcribe/latest/dg/vocabulary-filtering.html).
    vocabulary_filter_names: ?[]const u8 = null,

    /// Specify the name of the custom vocabulary that you want to use when
    /// processing your
    /// transcription. Note that vocabulary names are case sensitive.
    ///
    /// If the language of the specified custom vocabulary doesn't match the
    /// language identified in
    /// your media, the custom vocabulary is not applied to your transcription.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html).
    vocabulary_name: ?[]const u8 = null,

    /// Specify the names of the custom vocabularies that you want to use when
    /// processing your
    /// Call Analytics transcription. Note that vocabulary names are case sensitive.
    ///
    /// If the custom vocabulary's language doesn't match the identified media
    /// language, it won't be applied to the transcription.
    ///
    /// This parameter is only intended for use **with** the
    /// `IdentifyLanguage` parameter. If you're **not**
    /// including `IdentifyLanguage` in your request and want to use a custom
    /// vocabulary
    /// with your transcription, use the `VocabularyName` parameter instead.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html).
    vocabulary_names: ?[]const u8 = null,

    pub const json_field_names = .{
        .audio_stream = "AudioStream",
        .content_identification_type = "ContentIdentificationType",
        .content_redaction_type = "ContentRedactionType",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .identify_language = "IdentifyLanguage",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .preferred_language = "PreferredLanguage",
        .session_id = "SessionId",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_filter_names = "VocabularyFilterNames",
        .vocabulary_name = "VocabularyName",
        .vocabulary_names = "VocabularyNames",
    };
};

pub const StartCallAnalyticsStreamTranscriptionOutput = struct {
    /// Provides detailed information about your real-time Call Analytics session.
    call_analytics_transcript_result_stream: ?CallAnalyticsTranscriptResultStream = null,

    /// Shows whether content identification was enabled for your Call Analytics
    /// transcription.
    content_identification_type: ?ContentIdentificationType = null,

    /// Shows whether content redaction was enabled for your Call Analytics
    /// transcription.
    content_redaction_type: ?ContentRedactionType = null,

    /// Shows whether partial results stabilization was enabled for your Call
    /// Analytics transcription.
    enable_partial_results_stabilization: bool = false,

    /// Shows whether automatic language identification was enabled for your Call
    /// Analytics transcription.
    identify_language: bool = false,

    /// Provides the language code that you specified in your Call Analytics
    /// request.
    language_code: ?CallAnalyticsLanguageCode = null,

    /// Provides the name of the custom language model that you specified in your
    /// Call Analytics
    /// request.
    language_model_name: ?[]const u8 = null,

    /// Provides the language codes that you specified in your Call Analytics
    /// request.
    language_options: ?[]const u8 = null,

    /// Provides the media encoding you specified in your Call Analytics request.
    media_encoding: ?MediaEncoding = null,

    /// Provides the sample rate that you specified in your Call Analytics request.
    media_sample_rate_hertz: ?i32 = null,

    /// Provides the stabilization level used for your transcription.
    partial_results_stability: ?PartialResultsStability = null,

    /// Lists the PII entity types you specified in your Call Analytics request.
    pii_entity_types: ?[]const u8 = null,

    /// Provides the preferred language that you specified in your Call Analytics
    /// request.
    preferred_language: ?CallAnalyticsLanguageCode = null,

    /// Provides the identifier for your real-time Call Analytics request.
    request_id: ?[]const u8 = null,

    /// Provides the identifier for your Call Analytics transcription session.
    session_id: ?[]const u8 = null,

    /// Provides the vocabulary filtering method used in your Call Analytics
    /// transcription.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// Provides the name of the custom vocabulary filter that you specified in your
    /// Call Analytics
    /// request.
    vocabulary_filter_name: ?[]const u8 = null,

    /// Provides the names of the custom vocabulary filters that you specified in
    /// your Call Analytics request.
    vocabulary_filter_names: ?[]const u8 = null,

    /// Provides the name of the custom vocabulary that you specified in your Call
    /// Analytics request.
    vocabulary_name: ?[]const u8 = null,

    /// Provides the names of the custom vocabularies that you specified in your
    /// Call Analytics request.
    vocabulary_names: ?[]const u8 = null,

    pub const json_field_names = .{
        .call_analytics_transcript_result_stream = "CallAnalyticsTranscriptResultStream",
        .content_identification_type = "ContentIdentificationType",
        .content_redaction_type = "ContentRedactionType",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .identify_language = "IdentifyLanguage",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .preferred_language = "PreferredLanguage",
        .request_id = "RequestId",
        .session_id = "SessionId",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_filter_names = "VocabularyFilterNames",
        .vocabulary_name = "VocabularyName",
        .vocabulary_names = "VocabularyNames",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCallAnalyticsStreamTranscriptionInput, options: Options) !StartCallAnalyticsStreamTranscriptionOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
