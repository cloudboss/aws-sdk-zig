const ItemType = @import("item_type.zig").ItemType;

/// A word, phrase, or punctuation mark in your transcription output, along with
/// various
/// associated attributes, such as confidence score, type, and start and end
/// times.
pub const MedicalItem = struct {
    /// The confidence score associated with a word or phrase in your transcript.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified item correctly matches the item spoken in
    /// your
    /// media.
    confidence: ?f64,

    /// The word or punctuation that was transcribed.
    content: ?[]const u8,

    /// The end time, in seconds, of the transcribed item.
    end_time: f64 = 0,

    /// If speaker partitioning is enabled, `Speaker` labels the speaker of the
    /// specified item.
    speaker: ?[]const u8,

    /// The start time, in seconds, of the transcribed item.
    start_time: f64 = 0,

    /// The type of item identified. Options are: `PRONUNCIATION` (spoken
    /// words) and `PUNCTUATION`.
    type: ?ItemType,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .content = "Content",
        .end_time = "EndTime",
        .speaker = "Speaker",
        .start_time = "StartTime",
        .type = "Type",
    };
};
