const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RealTimeContactAnalysisTranscriptItemRedaction = @import("real_time_contact_analysis_transcript_item_redaction.zig").RealTimeContactAnalysisTranscriptItemRedaction;
const RealTimeContactAnalysisSentimentLabel = @import("real_time_contact_analysis_sentiment_label.zig").RealTimeContactAnalysisSentimentLabel;
const RealTimeContactAnalysisTimeData = @import("real_time_contact_analysis_time_data.zig").RealTimeContactAnalysisTimeData;

/// The analyzed transcript segment.
pub const RealTimeContactAnalysisSegmentTranscript = struct {
    /// The content of the transcript. Can be redacted.
    content: []const u8,

    /// The type of content of the item. For example, `text/plain`.
    content_type: ?[]const u8,

    /// The display name of the participant.
    display_name: ?[]const u8,

    /// The identifier of the transcript.
    id: []const u8,

    /// The identifier of the participant.
    participant_id: []const u8,

    /// The role of the participant. For example, is it a customer, agent, or
    /// system.
    participant_role: ParticipantRole,

    /// Object describing redaction that was applied to the transcript. If
    /// transcript has the field it means part of the
    /// transcript was redacted.
    redaction: ?RealTimeContactAnalysisTranscriptItemRedaction,

    /// The sentiment detected for this piece of transcript.
    sentiment: ?RealTimeContactAnalysisSentimentLabel,

    /// Field describing the time of the event. It can have different
    /// representations of time.
    time: RealTimeContactAnalysisTimeData,

    pub const json_field_names = .{
        .content = "Content",
        .content_type = "ContentType",
        .display_name = "DisplayName",
        .id = "Id",
        .participant_id = "ParticipantId",
        .participant_role = "ParticipantRole",
        .redaction = "Redaction",
        .sentiment = "Sentiment",
        .time = "Time",
    };
};
