/// Contains entities identified as personal health information (PHI) in your
/// transcription output, along with various associated attributes. Examples
/// include
/// category, confidence score, type, stability score, and start and end times.
pub const MedicalEntity = struct {
    /// The category of information identified. The only category is `PHI`.
    category: ?[]const u8 = null,

    /// The confidence score associated with the identified PHI entity in your
    /// audio.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified entity correctly matches the entity spoken
    /// in your
    /// media.
    confidence: ?f64 = null,

    /// The word or words identified as PHI.
    content: ?[]const u8 = null,

    /// The end time, in seconds, of the utterance that was identified as PHI.
    end_time: f64 = 0,

    /// The start time, in seconds, of the utterance that was identified as PHI.
    start_time: f64 = 0,

    pub const json_field_names = .{
        .category = "Category",
        .confidence = "Confidence",
        .content = "Content",
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
