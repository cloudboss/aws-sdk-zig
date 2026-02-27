const MedicalScribeTranscriptItemType = @import("medical_scribe_transcript_item_type.zig").MedicalScribeTranscriptItemType;

/// A word, phrase, or punctuation mark in your transcription output, along with
/// various associated
/// attributes, such as confidence score, type, and start and end times.
pub const MedicalScribeTranscriptItem = struct {
    /// The start time, in milliseconds, of the transcribed item.
    begin_audio_time: f64 = 0,

    /// The confidence score associated with a word or phrase in your transcript.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified item correctly matches the item spoken in
    /// your media.
    confidence: ?f64,

    /// The word, phrase or punctuation mark that was transcribed.
    content: ?[]const u8,

    /// The end time, in milliseconds, of the transcribed item.
    end_audio_time: f64 = 0,

    /// The type of item identified. Options are: `PRONUNCIATION` (spoken words)
    /// and `PUNCTUATION`.
    type: ?MedicalScribeTranscriptItemType,

    /// Indicates whether the specified item matches a word in the vocabulary filter
    /// included in
    /// your configuration event. If `true`, there is a vocabulary filter match.
    vocabulary_filter_match: ?bool,

    pub const json_field_names = .{
        .begin_audio_time = "BeginAudioTime",
        .confidence = "Confidence",
        .content = "Content",
        .end_audio_time = "EndAudioTime",
        .type = "Type",
        .vocabulary_filter_match = "VocabularyFilterMatch",
    };
};
