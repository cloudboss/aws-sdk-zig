const ItemType = @import("item_type.zig").ItemType;

/// A word, phrase, or punctuation mark in your Call Analytics transcription
/// output, along with various
/// associated attributes, such as confidence score, type, and start and end
/// times.
pub const CallAnalyticsItem = struct {
    /// The time, in milliseconds, from the beginning of the audio stream to the
    /// start of the identified item.
    begin_offset_millis: ?i64,

    /// The confidence score associated with a word or phrase in your transcript.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified item correctly matches the item spoken in
    /// your media.
    confidence: ?f64,

    /// The word or punctuation that was transcribed.
    content: ?[]const u8,

    /// The time, in milliseconds, from the beginning of the audio stream to the end
    /// of the identified item.
    end_offset_millis: ?i64,

    /// If partial result stabilization is enabled, `Stable` indicates whether the
    /// specified
    /// item is stable (`true`) or if it may change when the segment is complete
    /// (`false`).
    stable: ?bool,

    /// The type of item identified. Options are: `PRONUNCIATION` (spoken words) and
    /// `PUNCTUATION`.
    type: ?ItemType,

    /// Indicates whether the specified item matches a word in the vocabulary filter
    /// included in
    /// your Call Analytics request. If `true`, there is a vocabulary filter match.
    vocabulary_filter_match: bool = false,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .confidence = "Confidence",
        .content = "Content",
        .end_offset_millis = "EndOffsetMillis",
        .stable = "Stable",
        .type = "Type",
        .vocabulary_filter_match = "VocabularyFilterMatch",
    };
};
