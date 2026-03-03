const IssueDetected = @import("issue_detected.zig").IssueDetected;
const SentimentValue = @import("sentiment_value.zig").SentimentValue;

/// A list of messages in the session.
pub const Transcript = struct {
    /// The beginning offset in the contact for this transcript.
    begin_offset_millis: i32,

    /// The content of the transcript.
    content: []const u8,

    /// The end offset in the contact for this transcript.
    end_offset_millis: i32,

    /// The identifier of the transcript.
    id: []const u8,

    /// List of positions where issues were detected on the transcript.
    issues_detected: ?[]const IssueDetected = null,

    /// The identifier of the participant. Valid values are CUSTOMER or AGENT.
    participant_id: []const u8,

    /// The role of participant. For example, is it a customer, agent, or system.
    participant_role: []const u8,

    /// The sentiment detected for this piece of transcript.
    sentiment: ?SentimentValue = null,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
        .content = "Content",
        .end_offset_millis = "EndOffsetMillis",
        .id = "Id",
        .issues_detected = "IssuesDetected",
        .participant_id = "ParticipantId",
        .participant_role = "ParticipantRole",
        .sentiment = "Sentiment",
    };
};
