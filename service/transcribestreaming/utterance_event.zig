const CallAnalyticsEntity = @import("call_analytics_entity.zig").CallAnalyticsEntity;
const IssueDetected = @import("issue_detected.zig").IssueDetected;
const CallAnalyticsItem = @import("call_analytics_item.zig").CallAnalyticsItem;
const CallAnalyticsLanguageCode = @import("call_analytics_language_code.zig").CallAnalyticsLanguageCode;
const CallAnalyticsLanguageWithScore = @import("call_analytics_language_with_score.zig").CallAnalyticsLanguageWithScore;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const Sentiment = @import("sentiment.zig").Sentiment;

/// Contains set of transcription results from one or more audio segments, along
/// with additional
/// information about the parameters included in your request. For example,
/// channel definitions, partial result
/// stabilization, sentiment, and issue detection.
pub const UtteranceEvent = struct {
    /// The time, in milliseconds, from the beginning of the audio stream to the
    /// start of the
    /// `UtteranceEvent`.
    begin_offset_millis: ?i64,

    /// The time, in milliseconds, from the beginning of the audio stream to the
    /// start of the
    /// `UtteranceEvent`.
    end_offset_millis: ?i64,

    /// Contains entities identified as personally identifiable information (PII) in
    /// your transcription
    /// output.
    entities: ?[]const CallAnalyticsEntity,

    /// Indicates whether the segment in the `UtteranceEvent` is complete
    /// (`FALSE`) or partial (`TRUE`).
    is_partial: bool = false,

    /// Provides the issue that was detected in the specified segment.
    issues_detected: ?[]const IssueDetected,

    /// Contains words, phrases, or punctuation marks that are associated with the
    /// specified
    /// `UtteranceEvent`.
    items: ?[]const CallAnalyticsItem,

    /// The language code that represents the language spoken in your audio stream.
    language_code: ?CallAnalyticsLanguageCode,

    /// The language code of the dominant language identified in your stream.
    language_identification: ?[]const CallAnalyticsLanguageWithScore,

    /// Provides the role of the speaker for each audio channel, either `CUSTOMER`
    /// or
    /// `AGENT`.
    participant_role: ?ParticipantRole,

    /// Provides the sentiment that was detected in the specified segment.
    sentiment: ?Sentiment,

    /// Contains transcribed text.
    transcript: ?[]const u8,

    /// The unique identifier that is associated with the specified
    /// `UtteranceEvent`.
    utterance_id: ?[]const u8,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .end_offset_millis = "EndOffsetMillis",
        .entities = "Entities",
        .is_partial = "IsPartial",
        .issues_detected = "IssuesDetected",
        .items = "Items",
        .language_code = "LanguageCode",
        .language_identification = "LanguageIdentification",
        .participant_role = "ParticipantRole",
        .sentiment = "Sentiment",
        .transcript = "Transcript",
        .utterance_id = "UtteranceId",
    };
};
