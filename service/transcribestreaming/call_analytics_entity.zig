/// Contains entities identified as personally identifiable information (PII) in
/// your
/// transcription output, along with various associated attributes. Examples
/// include category,
/// confidence score, content, type, and start and end times.
pub const CallAnalyticsEntity = struct {
    /// The time, in milliseconds, from the beginning of the audio stream to the
    /// start of the identified entity.
    begin_offset_millis: ?i64 = null,

    /// The category of information identified. For example, `PII`.
    category: ?[]const u8 = null,

    /// The confidence score associated with the identification of an entity in your
    /// transcript.
    ///
    /// Confidence scores are values between 0 and 1. A larger value indicates a
    /// higher
    /// probability that the identified entity correctly matches the entity spoken
    /// in your
    /// media.
    confidence: ?f64 = null,

    /// The word or words that represent the identified entity.
    content: ?[]const u8 = null,

    /// The time, in milliseconds, from the beginning of the audio stream to the end
    /// of the identified entity.
    end_offset_millis: ?i64 = null,

    /// The type of PII identified. For example, `NAME` or
    /// `CREDIT_DEBIT_NUMBER`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .category = "Category",
        .confidence = "Confidence",
        .content = "Content",
        .end_offset_millis = "EndOffsetMillis",
        .@"type" = "Type",
    };
};
