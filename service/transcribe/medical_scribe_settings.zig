const ClinicalNoteGenerationSettings = @import("clinical_note_generation_settings.zig").ClinicalNoteGenerationSettings;
const VocabularyFilterMethod = @import("vocabulary_filter_method.zig").VocabularyFilterMethod;

/// Makes it possible to control how your Medical Scribe job is processed using
/// a
/// `MedicalScribeSettings` object. Specify `ChannelIdentification` if
/// `ChannelDefinitions` are set. Enabled `ShowSpeakerLabels` if
/// `ChannelIdentification`
/// and `ChannelDefinitions` are not set. One and only one of
/// `ChannelIdentification` and `ShowSpeakerLabels`
/// must be set. If `ShowSpeakerLabels` is set, `MaxSpeakerLabels` must also be
/// set. Use `Settings`
/// to specify a vocabulary or vocabulary filter or both using `VocabularyName`,
/// `VocabularyFilterName`.
/// `VocabularyFilterMethod` must be specified if `VocabularyFilterName` is set.
pub const MedicalScribeSettings = struct {
    /// Enables channel identification in multi-channel audio.
    ///
    /// Channel identification transcribes the audio on each channel independently,
    /// then
    /// appends the output for each channel into one transcript.
    ///
    /// For more information, see [Transcribing multi-channel
    /// audio](https://docs.aws.amazon.com/transcribe/latest/dg/channel-id.html).
    channel_identification: ?bool = null,

    /// Specify settings for the clinical note generation.
    clinical_note_generation_settings: ?ClinicalNoteGenerationSettings = null,

    /// Specify the maximum number of speakers you want to partition in your media.
    ///
    /// Note that if your media contains more speakers than the specified number,
    /// multiple
    /// speakers are treated as a single speaker.
    ///
    /// If you specify the `MaxSpeakerLabels` field, you must set the
    /// `ShowSpeakerLabels` field to true.
    max_speaker_labels: ?i32 = null,

    /// Enables speaker partitioning (diarization) in your Medical Scribe output.
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

    /// The name of the custom vocabulary filter you want to include in your Medical
    /// Scribe
    /// request. Custom vocabulary filter names are case sensitive.
    ///
    /// Note that if you include `VocabularyFilterName` in your request, you must
    /// also include `VocabularyFilterMethod`.
    vocabulary_filter_name: ?[]const u8 = null,

    /// The name of the custom vocabulary you want to include in your Medical Scribe
    /// request. Custom vocabulary names are case sensitive.
    vocabulary_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_identification = "ChannelIdentification",
        .clinical_note_generation_settings = "ClinicalNoteGenerationSettings",
        .max_speaker_labels = "MaxSpeakerLabels",
        .show_speaker_labels = "ShowSpeakerLabels",
        .vocabulary_filter_method = "VocabularyFilterMethod",
        .vocabulary_filter_name = "VocabularyFilterName",
        .vocabulary_name = "VocabularyName",
    };
};
