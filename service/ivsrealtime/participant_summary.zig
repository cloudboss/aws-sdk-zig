const ParticipantRecordingState = @import("participant_recording_state.zig").ParticipantRecordingState;
const ReplicationState = @import("replication_state.zig").ReplicationState;
const ReplicationType = @import("replication_type.zig").ReplicationType;
const ParticipantState = @import("participant_state.zig").ParticipantState;

/// Summary object describing a participant that has joined a stage.
pub const ParticipantSummary = struct {
    /// ISO 8601 timestamp (returned as a string) when the participant first joined
    /// the stage
    /// session.
    first_join_time: ?i64 = null,

    /// Unique identifier for this participant, assigned by IVS.
    participant_id: ?[]const u8 = null,

    /// Whether the participant ever published to the stage session.
    published: bool = false,

    /// The participant’s recording state.
    recording_state: ?ParticipantRecordingState = null,

    /// The participant's replication state.
    replication_state: ?ReplicationState = null,

    /// Indicates if the participant has been replicated to another stage or is a
    /// replica from another stage. Default: `NONE`.
    replication_type: ?ReplicationType = null,

    /// ID of the session within the source stage, if `replicationType` is
    /// `REPLICA`.
    source_session_id: ?[]const u8 = null,

    /// Source stage ARN from which this participant is replicated, if
    /// `replicationType` is `REPLICA`.
    source_stage_arn: ?[]const u8 = null,

    /// Whether the participant is connected to or disconnected from the stage.
    state: ?ParticipantState = null,

    /// Customer-assigned name to help identify the token; this can be used to link
    /// a
    /// participant to a user in the customer’s own systems. This can be any UTF-8
    /// encoded text.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information*.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_join_time = "firstJoinTime",
        .participant_id = "participantId",
        .published = "published",
        .recording_state = "recordingState",
        .replication_state = "replicationState",
        .replication_type = "replicationType",
        .source_session_id = "sourceSessionId",
        .source_stage_arn = "sourceStageArn",
        .state = "state",
        .user_id = "userId",
    };
};
