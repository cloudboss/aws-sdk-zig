const ItemType = @import("item_type.zig").ItemType;

/// A word, phrase, or punctuation mark in your transcription output, along with
/// various associated
/// attributes, such as confidence score, type, and start and end times.
pub const Item = struct {
    /// The confidence score associated with a word or phrase in your transcript.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified item correctly matches the item spoken in
    /// your media.
    confidence: ?f64,

    /// The word or punctuation that was transcribed.
    content: ?[]const u8,

    /// The end time of the transcribed item in seconds, with millisecond precision
    /// (e.g., 1.056)
    end_time: f64 = 0,

    /// If speaker partitioning is enabled, `Speaker` labels the speaker of the
    /// specified item.
    speaker: ?[]const u8,

    /// If partial result stabilization is enabled, `Stable` indicates whether the
    /// specified
    /// item is stable (`true`) or if it may change when the segment is complete
    /// (`false`).
    stable: ?bool,

    /// The start time of the transcribed item in seconds, with millisecond
    /// precision (e.g., 1.056)
    start_time: f64 = 0,

    /// The type of item identified. Options are: `PRONUNCIATION` (spoken words) and
    /// `PUNCTUATION`.
    type: ?ItemType,

    /// Indicates whether the specified item matches a word in the vocabulary filter
    /// included in
    /// your request. If `true`, there is a vocabulary filter match.
    vocabulary_filter_match: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .content = "Content",
        .end_time = "EndTime",
        .speaker = "Speaker",
        .stable = "Stable",
        .start_time = "StartTime",
        .type = "Type",
        .vocabulary_filter_match = "VocabularyFilterMatch",
    };
};
