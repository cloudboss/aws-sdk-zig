const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AudioStream = @import("audio_stream.zig").AudioStream;
const ContentIdentificationType = @import("content_identification_type.zig").ContentIdentificationType;
const ContentRedactionType = @import("content_redaction_type.zig").ContentRedactionType;
const LanguageCode = @import("language_code.zig").LanguageCode;
const MediaEncoding = @import("media_encoding.zig").MediaEncoding;
const PartialResultsStability = @import("partial_results_stability.zig").PartialResultsStability;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;
const TranscriptResultStream = @import("transcript_result_stream.zig").TranscriptResultStream;

pub const StartStreamTranscriptionInput = struct {
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

    /// Enables channel identification in multi-channel audio.
    ///
    /// Channel identification transcribes the audio on each channel independently,
    /// then appends the
    /// output for each channel into one transcript.
    ///
    /// If you have multi-channel audio and do not enable channel identification,
    /// your audio is
    /// transcribed in a continuous manner and your transcript is not separated by
    /// channel.
    ///
    /// If you include `EnableChannelIdentification` in your request, you must also
    /// include `NumberOfChannels`.
    ///
    /// For more information, see [Transcribing multi-channel
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/channel-id.html).
    enable_channel_identification: ?bool = null,

    /// Enables partial result stabilization for your transcription. Partial result
    /// stabilization can reduce
    /// latency in your output, but may impact accuracy. For more information, see
    /// [Partial-result
    /// stabilization](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html#streaming-partial-result-stabilization).
    enable_partial_results_stabilization: ?bool = null,

    /// Enables automatic language identification for your transcription.
    ///
    /// If you include `IdentifyLanguage`, you must include a list of
    /// language codes, using `LanguageOptions`, that you think may be present in
    /// your audio stream.
    ///
    /// You can also include a preferred language using `PreferredLanguage`. Adding
    /// a
    /// preferred language can help Amazon Transcribe identify the language faster
    /// than if you omit this
    /// parameter.
    ///
    /// If you have multi-channel audio that contains different languages on each
    /// channel, and you've
    /// enabled channel identification, automatic language identification identifies
    /// the dominant language on
    /// each audio channel.
    ///
    /// Note that you must include either `LanguageCode` or
    /// `IdentifyLanguage` or `IdentifyMultipleLanguages` in your request. If you
    /// include more than one of these parameters, your transcription job
    /// fails.
    ///
    /// Streaming language identification can't be combined with custom language
    /// models or
    /// redaction.
    identify_language: ?bool = null,

    /// Enables automatic multi-language identification in your transcription job
    /// request. Use this parameter if your stream contains more than one language.
    /// If your stream contains only one language, use IdentifyLanguage instead.
    ///
    /// If you include `IdentifyMultipleLanguages`, you must include a list of
    /// language codes, using `LanguageOptions`, that you think may be present in
    /// your stream.
    ///
    /// If you want to apply a custom vocabulary or a custom vocabulary filter to
    /// your automatic multiple language identification request, include
    /// `VocabularyNames` or `VocabularyFilterNames`.
    ///
    /// Note that you must include one of `LanguageCode`, `IdentifyLanguage`, or
    /// `IdentifyMultipleLanguages` in your request. If you include more than one of
    /// these parameters, your transcription job fails.
    identify_multiple_languages: ?bool = null,

    /// Specify the language code that represents the language spoken in your audio.
    ///
    /// If you're unsure of the language spoken in your audio, consider using
    /// `IdentifyLanguage` to enable automatic language identification.
    ///
    /// For a list of languages supported with Amazon Transcribe streaming, refer to
    /// the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    language_code: ?LanguageCode = null,

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
    /// in your media; including more than five is not recommended.
    ///
    /// Including language options can improve the accuracy of language
    /// identification.
    ///
    /// If you include `LanguageOptions` in your request, you must also include
    /// `IdentifyLanguage` or `IdentifyMultipleLanguages`.
    ///
    /// For a list of languages supported with Amazon Transcribe streaming, refer to
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

    /// Specify the number of channels in your audio stream. This value must be
    /// `2`, as only two channels are supported. If your audio doesn't contain
    /// multiple channels, do not include this parameter in your request.
    ///
    /// If you include `NumberOfChannels` in your request, you must also
    /// include `EnableChannelIdentification`.
    number_of_channels: ?i32 = null,

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
    /// `SSN`, `AGE`, `DATE_TIME`,
    /// `LICENSE_PLATE`, `PASSPORT_NUMBER`,
    /// `PASSWORD`, `USERNAME`, `VEHICLE_IDENTIFICATION_NUMBER`, or `ALL`.
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
    preferred_language: ?LanguageCode = null,

    /// Specify a name for your transcription session. If you don't include this
    /// parameter in your request,
    /// Amazon Transcribe generates an ID and returns it in the response.
    session_id: ?[]const u8 = null,

    /// Specify the time window, in minutes, during which your transcription session
    /// can be resumed,
    /// measured from the stream start time. This optional parameter accepts integer
    /// values from 1 to 300 (5 hours).
    ///
    /// For example, if your stream starts at 1 PM and you specify a
    /// `SessionResumeWindow` of 30 minutes,
    /// you can reconnect to the session as many times as you want until 1:30 PM.
    session_resume_window: ?i32 = null,

    /// Enables speaker partitioning (diarization) in your transcription output.
    /// Speaker partitioning
    /// labels the speech from individual speakers in your media file.
    ///
    /// For more information, see [Partitioning speakers
    /// (diarization)](https://docs.aws.amazon.com/transcribe/latest/dg/diarization.html).
    show_speaker_label: ?bool = null,

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
    /// This parameter is **not** intended for use with the
    /// `IdentifyLanguage` parameter. If you're including `IdentifyLanguage`
    /// in your request and want to use one or more vocabulary filters with your
    /// transcription, use
    /// the `VocabularyFilterNames` parameter instead.
    ///
    /// For more information, see [Using vocabulary filtering with unwanted
    /// words](https://docs.aws.amazon.com/transcribe/latest/dg/vocabulary-filtering.html).
    vocabulary_filter_name: ?[]const u8 = null,

    /// Specify the names of the custom vocabulary filters that you want to use when
    /// processing
    /// your transcription. Note that vocabulary filter names are case sensitive.
    ///
    /// If none of the languages of the specified custom vocabulary filters match
    /// the language identified
    /// in your media, your job fails.
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
    /// This parameter is **not** intended for use with the
    /// `IdentifyLanguage` parameter. If you're including `IdentifyLanguage`
    /// in your request and want to use one or more custom vocabularies with your
    /// transcription, use
    /// the `VocabularyNames` parameter instead.
    ///
    /// For more information, see [Custom
    /// vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary.html).
    vocabulary_name: ?[]const u8 = null,

    /// Specify the names of the custom vocabularies that you want to use when
    /// processing your
    /// transcription. Note that vocabulary names are case sensitive.
    ///
    /// If none of the languages of the specified custom vocabularies match the
    /// language identified in
    /// your media, your job fails.
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
        .enable_channel_identification = "EnableChannelIdentification",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .identify_language = "IdentifyLanguage",
        .identify_multiple_languages = "IdentifyMultipleLanguages",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .number_of_channels = "NumberOfChannels",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .preferred_language = "PreferredLanguage",
        .session_id = "SessionId",
        .session_resume_window = "SessionResumeWindow",
        .show_speaker_label = "ShowSpeakerLabel",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_filter_names = "VocabularyFilterNames",
        .vocabulary_name = "VocabularyName",
        .vocabulary_names = "VocabularyNames",
    };
};

pub const StartStreamTranscriptionOutput = struct {
    /// Shows whether content identification was enabled for your transcription.
    content_identification_type: ?ContentIdentificationType = null,

    /// Shows whether content redaction was enabled for your transcription.
    content_redaction_type: ?ContentRedactionType = null,

    /// Shows whether channel identification was enabled for your transcription.
    enable_channel_identification: ?bool = null,

    /// Shows whether partial results stabilization was enabled for your
    /// transcription.
    enable_partial_results_stabilization: ?bool = null,

    /// Shows whether automatic language identification was enabled for your
    /// transcription.
    identify_language: ?bool = null,

    /// Shows whether automatic multi-language identification was enabled for your
    /// transcription.
    identify_multiple_languages: ?bool = null,

    /// Provides the language code that you specified in your request.
    language_code: ?LanguageCode = null,

    /// Provides the name of the custom language model that you specified in your
    /// request.
    language_model_name: ?[]const u8 = null,

    /// Provides the language codes that you specified in your request.
    language_options: ?[]const u8 = null,

    /// Provides the media encoding you specified in your request.
    media_encoding: ?MediaEncoding = null,

    /// Provides the sample rate that you specified in your request.
    media_sample_rate_hertz: ?i32 = null,

    /// Provides the number of channels that you specified in your request.
    number_of_channels: ?i32 = null,

    /// Provides the stabilization level used for your transcription.
    partial_results_stability: ?PartialResultsStability = null,

    /// Lists the PII entity types you specified in your request.
    pii_entity_types: ?[]const u8 = null,

    /// Provides the preferred language that you specified in your request.
    preferred_language: ?LanguageCode = null,

    /// Provides the identifier for your streaming request.
    request_id: ?[]const u8 = null,

    /// Provides the identifier for your transcription session.
    session_id: ?[]const u8 = null,

    /// Provides the session resume window, in minutes, that you specified in your
    /// request.
    session_resume_window: ?i32 = null,

    /// Shows whether speaker partitioning was enabled for your transcription.
    show_speaker_label: ?bool = null,

    /// Provides detailed information about your streaming session.
    transcript_result_stream: ?TranscriptResultStream = null,

    /// Provides the vocabulary filtering method used in your transcription.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// Provides the name of the custom vocabulary filter that you specified in your
    /// request.
    vocabulary_filter_name: ?[]const u8 = null,

    /// Provides the names of the custom vocabulary filters that you specified in
    /// your
    /// request.
    vocabulary_filter_names: ?[]const u8 = null,

    /// Provides the name of the custom vocabulary that you specified in your
    /// request.
    vocabulary_name: ?[]const u8 = null,

    /// Provides the names of the custom vocabularies that you specified in your
    /// request.
    vocabulary_names: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_identification_type = "ContentIdentificationType",
        .content_redaction_type = "ContentRedactionType",
        .enable_channel_identification = "EnableChannelIdentification",
        .enable_partial_results_stabilization = "EnablePartialResultsStabilization",
        .identify_language = "IdentifyLanguage",
        .identify_multiple_languages = "IdentifyMultipleLanguages",
        .language_code = "LanguageCode",
        .language_model_name = "LanguageModelName",
        .language_options = "LanguageOptions",
        .media_encoding = "MediaEncoding",
        .media_sample_rate_hertz = "MediaSampleRateHertz",
        .number_of_channels = "NumberOfChannels",
        .partial_results_stability = "PartialResultsStability",
        .pii_entity_types = "PiiEntityTypes",
        .preferred_language = "PreferredLanguage",
        .request_id = "RequestId",
        .session_id = "SessionId",
        .session_resume_window = "SessionResumeWindow",
        .show_speaker_label = "ShowSpeakerLabel",
        .transcript_result_stream = "TranscriptResultStream",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_filter_names = "VocabularyFilterNames",
        .vocabulary_name = "VocabularyName",
        .vocabulary_names = "VocabularyNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartStreamTranscriptionInput, options: CallOptions) !StartStreamTranscriptionOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    // Requires HTTP/2 bidirectional streaming
    return error.EventStreamNotSupported;
}
