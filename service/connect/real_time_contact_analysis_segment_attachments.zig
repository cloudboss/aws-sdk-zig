const RealTimeContactAnalysisAttachment = @import("real_time_contact_analysis_attachment.zig").RealTimeContactAnalysisAttachment;
const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RealTimeContactAnalysisTimeData = @import("real_time_contact_analysis_time_data.zig").RealTimeContactAnalysisTimeData;

/// Segment containing list of attachments.
pub const RealTimeContactAnalysisSegmentAttachments = struct {
    /// List of objects describing an individual attachment.
    attachments: []const RealTimeContactAnalysisAttachment,

    /// The display name of the participant. Can be redacted.
    display_name: ?[]const u8,

    /// The identifier of the segment.
    id: []const u8,

    /// The identifier of the participant.
    participant_id: []const u8,

    /// The role of the participant. For example, is it a customer, agent, or
    /// system.
    participant_role: ParticipantRole,

    /// Field describing the time of the event. It can have different
    /// representations of time.
    time: RealTimeContactAnalysisTimeData,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .display_name = "DisplayName",
        .id = "Id",
        .participant_id = "ParticipantId",
        .participant_role = "ParticipantRole",
        .time = "Time",
    };
};
