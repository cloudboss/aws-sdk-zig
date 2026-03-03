/// Contains entities identified as personally identifiable information (PII) in
/// your
/// transcription output, along with various associated attributes. Examples
/// include category,
/// confidence score, type, stability score, and start and end times.
pub const Entity = struct {
    /// The category of information identified. The only category is `PII`.
    category: ?[]const u8 = null,

    /// The confidence score associated with the identified PII entity in your
    /// audio.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified entity correctly matches the entity spoken
    /// in your
    /// media.
    confidence: ?f64 = null,

    /// The word or words identified as PII.
    content: ?[]const u8 = null,

    /// The end time of the utterance that was identified as PII in seconds, with
    /// millisecond precision (e.g., 1.056)
    end_time: f64 = 0,

    /// The start time of the utterance that was identified as PII in seconds, with
    /// millisecond precision (e.g., 1.056)
    start_time: f64 = 0,

    /// The type of PII identified. For example, `NAME` or
    /// `CREDIT_DEBIT_NUMBER`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .confidence = "Confidence",
        .content = "Content",
        .end_time = "EndTime",
        .start_time = "StartTime",
        .@"type" = "Type",
    };
};
