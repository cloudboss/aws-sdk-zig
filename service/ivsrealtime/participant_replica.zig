const ReplicationState = @import("replication_state.zig").ReplicationState;

/// Information about the replicated destination stage for a participant.
pub const ParticipantReplica = struct {
    /// ID of the session within the destination stage.
    destination_session_id: []const u8,

    /// ARN of the stage where the participant is replicated.
    destination_stage_arn: []const u8,

    /// Participant ID of the publisher that will be replicated. This is assigned by
    /// IVS and returned by
    /// CreateParticipantToken
    /// or the `jti` (JWT ID) used to [
    /// create a self signed
    /// token](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/getting-started-distribute-tokens.html#getting-started-distribute-tokens-self-signed).
    participant_id: []const u8,

    /// Replica’s current replication state.
    replication_state: ReplicationState,

    /// ID of the session within the source stage.
    source_session_id: []const u8,

    /// ARN of the stage from which this participant is replicated.
    source_stage_arn: []const u8,

    pub const json_field_names = .{
        .destination_session_id = "destinationSessionId",
        .destination_stage_arn = "destinationStageArn",
        .participant_id = "participantId",
        .replication_state = "replicationState",
        .source_session_id = "sourceSessionId",
        .source_stage_arn = "sourceStageArn",
    };
};
