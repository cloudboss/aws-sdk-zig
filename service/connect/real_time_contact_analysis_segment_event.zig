const ParticipantRole = @import("participant_role.zig").ParticipantRole;
const RealTimeContactAnalysisTimeData = @import("real_time_contact_analysis_time_data.zig").RealTimeContactAnalysisTimeData;

/// Segment type describing a contact event.
pub const RealTimeContactAnalysisSegmentEvent = struct {
    /// The display name of the participant. Can be redacted.
    display_name: ?[]const u8 = null,

    /// Type of the event. For example,
    /// `application/vnd.amazonaws.connect.event.participant.left`.
    event_type: []const u8,

    /// The identifier of the contact event.
    id: []const u8,

    /// The identifier of the participant.
    participant_id: ?[]const u8 = null,

    /// The role of the participant. For example, is it a customer, agent, or
    /// system.
    participant_role: ?ParticipantRole = null,

    /// Field describing the time of the event. It can have different
    /// representations of time.
    time: RealTimeContactAnalysisTimeData,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .event_type = "EventType",
        .id = "Id",
        .participant_id = "ParticipantId",
        .participant_role = "ParticipantRole",
        .time = "Time",
    };
};
