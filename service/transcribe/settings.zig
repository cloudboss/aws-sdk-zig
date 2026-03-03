const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;

/// Allows additional optional settings in your
/// request, including channel identification, alternative transcriptions, and
/// speaker
/// partitioning. You can use that to apply custom vocabularies to your
/// transcription
/// job.
pub const Settings = struct {
    /// Enables channel identification in multi-channel audio.
    ///
    /// Channel identification transcribes the audio on each channel independently,
    /// then
    /// appends the output for each channel into one transcript.
    ///
    /// For more information, see [Transcribing multi-channel
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/channel-id.html).
    channel_identification: ?bool = null,

    /// Indicate the maximum number of alternative transcriptions you want Amazon
    /// Transcribe
    /// to include in your transcript.
    ///
    /// If you select a number greater than the number of alternative transcriptions
    /// generated
    /// by Amazon Transcribe, only the actual number of alternative transcriptions
    /// are
    /// included.
    ///
    /// If you include `MaxAlternatives` in your request, you must also include
    /// `ShowAlternatives` with a value of `true`.
    ///
    /// For more information, see [Alternative
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/how-alternatives.html).
    max_alternatives: ?i32 = null,

    /// Specify the maximum number of speakers you want to partition in your media.
    ///
    /// Note that if your media contains more speakers than the specified number,
    /// multiple
    /// speakers are treated as a single speaker.
    ///
    /// If you specify the `MaxSpeakerLabels` field, you must set the
    /// `ShowSpeakerLabels` field to true.
    max_speaker_labels: ?i32 = null,

    /// To include alternative transcriptions within your transcription output,
    /// include
    /// `ShowAlternatives` in your transcription request.
    ///
    /// If you have multi-channel audio and do not enable channel identification,
    /// your audio
    /// is transcribed in a continuous manner and your transcript does not separate
    /// the speech
    /// by channel.
    ///
    /// If you include `ShowAlternatives`, you must also include
    /// `MaxAlternatives`, which is the maximum number of alternative
    /// transcriptions you want Amazon Transcribe to generate.
    ///
    /// For more information, see [Alternative
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/how-alternatives.html).
    show_alternatives: ?bool = null,

    /// Enables speaker partitioning (diarization) in your transcription output.
    /// Speaker
    /// partitioning labels the speech from individual speakers in your media file.
    ///
    /// If you enable `ShowSpeakerLabels` in your request, you must also include
    /// `MaxSpeakerLabels`.
    ///
    /// For more information, see [Partitioning speakers
    /// (diarization)](https://docs.aws.amazon.com/transcribe/latest/dg/diarization.html).
    show_speaker_labels: ?bool = null,

    /// Specify how you want your custom vocabulary filter applied to your
    /// transcript.
    ///
    /// To replace words with `***`, choose `mask`.
    ///
    /// To delete words, choose `remove`.
    ///
    /// To flag words without changing them, choose `tag`.
    vocabulary_filter_method: ?VocabularyFilterMethod = null,

    /// The name of the custom vocabulary filter you want to use in your
    /// transcription job
    /// request. This name is case sensitive, cannot contain spaces, and must be
    /// unique within
    /// an Amazon Web Services account.
    ///
    /// Note that if you include `VocabularyFilterName` in your request, you must
    /// also include `VocabularyFilterMethod`.
    vocabulary_filter_name: ?[]const u8 = null,

    /// The name of the custom vocabulary you want to use in your transcription job
    /// request.
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an Amazon Web Services account.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_identification = "ChannelIdentification",
        .max_alternatives = "MaxAlternatives",
        .max_speaker_labels = "MaxSpeakerLabels",
        .show_alternatives = "ShowAlternatives",
        .show_speaker_labels = "ShowSpeakerLabels",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
