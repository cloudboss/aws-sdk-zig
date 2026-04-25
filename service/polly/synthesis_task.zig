const Engine = @import("engine.zig").Engine;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputFormat = @import("output_format.zig").OutputFormat;
const SpeechMarkType = @import("speech_mark_type.zig").SpeechMarkType;
const TaskStatus = @import("task_status.zig").TaskStatus;
const TextType = @import("text_type.zig").TextType;
const VoiceId = @import("voice_id.zig").VoiceId;

/// SynthesisTask object that provides information about a speech
/// synthesis task.
pub const SynthesisTask = struct {
    /// Timestamp for the time the synthesis task was started.
    creation_time: ?i64 = null,

    /// Specifies the engine (`standard`, `neural`,
    /// `long-form` or `generative`) for Amazon Polly to use
    /// when processing input text for speech synthesis. Using a voice that
    /// is not supported for the engine selected will result in an error.
    engine: ?Engine = null,

    /// Optional language code for a synthesis task. This is only necessary if
    /// using a bilingual voice, such as Aditi, which can be used for either
    /// Indian English (en-IN) or Hindi (hi-IN).
    ///
    /// If a bilingual voice is used and no language code is specified, Amazon Polly
    /// uses the default language of the bilingual voice. The default language for
    /// any voice is the one returned by the
    /// [DescribeVoices](https://docs.aws.amazon.com/polly/latest/dg/API_DescribeVoices.html) operation for the `LanguageCode`
    /// parameter. For example, if no language code is specified, Aditi will use
    /// Indian English rather than Hindi.
    language_code: ?LanguageCode = null,

    /// List of one or more pronunciation lexicon names you want the service
    /// to apply during synthesis. Lexicons are applied only if the language of
    /// the lexicon is the same as the language of the voice.
    lexicon_names: ?[]const []const u8 = null,

    /// The format in which the returned output will be encoded. For audio
    /// stream, this will be mp3, ogg_vorbis, ogg_opus, mu-law, a-law, or pcm. For
    /// speech marks, this will
    /// be json.
    output_format: ?OutputFormat = null,

    /// Pathway for the output speech file.
    output_uri: ?[]const u8 = null,

    /// Number of billable characters synthesized.
    request_characters: i32 = 0,

    /// The audio frequency specified in Hz.
    ///
    /// The valid values for mp3 and ogg_vorbis are "8000", "16000", "22050",
    /// and "24000". The default value for standard voices is "22050". The default
    /// value for neural voices is "24000". The default value for long-form voices
    /// is "24000". The default value for generative voices is "24000".
    ///
    /// Valid values for pcm are "8000" and "16000" The default value is
    /// "16000".
    ///
    /// Valid value for ogg_opus is "48000".
    ///
    /// Valid value for mu-law and a-law is "8000".
    sample_rate: ?[]const u8 = null,

    /// ARN for the SNS topic optionally used for providing status
    /// notification for a speech synthesis task.
    sns_topic_arn: ?[]const u8 = null,

    /// The type of speech marks returned for the input text.
    speech_mark_types: ?[]const SpeechMarkType = null,

    /// The Amazon Polly generated identifier for a speech synthesis task.
    task_id: ?[]const u8 = null,

    /// Current status of the individual speech synthesis task.
    task_status: ?TaskStatus = null,

    /// Reason for the current status of a specific speech synthesis task,
    /// including errors if the task has failed.
    task_status_reason: ?[]const u8 = null,

    /// Specifies whether the input text is plain text or SSML. The default
    /// value is plain text.
    text_type: ?TextType = null,

    /// Voice ID to use for the synthesis.
    voice_id: ?VoiceId = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .engine = "Engine",
        .language_code = "LanguageCode",
        .lexicon_names = "LexiconNames",
        .output_format = "OutputFormat",
        .output_uri = "OutputUri",
        .request_characters = "RequestCharacters",
        .sample_rate = "SampleRate",
        .sns_topic_arn = "SnsTopicArn",
        .speech_mark_types = "SpeechMarkTypes",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
        .task_status_reason = "TaskStatusReason",
        .text_type = "TextType",
        .voice_id = "VoiceId",
    };
};
