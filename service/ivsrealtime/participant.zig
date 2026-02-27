const aws = @import("aws");

const ParticipantProtocol = @import("participant_protocol.zig").ParticipantProtocol;
const ParticipantRecordingState = @import("participant_recording_state.zig").ParticipantRecordingState;
const ReplicationState = @import("replication_state.zig").ReplicationState;
const ReplicationType = @import("replication_type.zig").ReplicationType;
const ParticipantState = @import("participant_state.zig").ParticipantState;

/// Object describing a participant that has joined a stage.
pub const Participant = struct {
    /// Application-provided attributes to encode into the token and attach to a
    /// stage. Map keys
    /// and values can contain UTF-8 encoded text. The maximum length of this field
    /// is 1 KB total.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information*.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The participant’s browser.
    browser_name: ?[]const u8,

    /// The participant’s browser version.
    browser_version: ?[]const u8,

    /// ISO 8601 timestamp (returned as a string) when the participant first joined
    /// the stage
    /// session.
    first_join_time: ?i64,

    /// The participant’s Internet Service Provider.
    isp_name: ?[]const u8,

    /// The participant’s operating system.
    os_name: ?[]const u8,

    /// The participant’s operating system version.
    os_version: ?[]const u8,

    /// Unique identifier for this participant, assigned by IVS.
    participant_id: ?[]const u8,

    /// Type of ingest protocol that the participant employs for broadcasting.
    protocol: ?ParticipantProtocol,

    /// Whether the participant ever published to the stage session.
    published: bool = false,

    /// Name of the S3 bucket to where the participant is being recorded, if
    /// individual
    /// participant recording is enabled, or `""` (empty string), if recording is
    /// not
    /// enabled.
    recording_s3_bucket_name: ?[]const u8,

    /// S3 prefix of the S3 bucket where the participant is being recorded, if
    /// individual
    /// participant recording is enabled, or `""` (empty string), if recording is
    /// not
    /// enabled. If individual participant recording merge is enabled, and if a
    /// stage publisher
    /// disconnects from a stage and then reconnects, IVS tries to record to the
    /// same S3 prefix as
    /// the previous session. See
    /// [
    /// Merge Fragmented Individual Participant
    /// Recordings](/ivs/latest/RealTimeUserGuide/rt-individual-participant-recording.html#ind-part-rec-merge-frag).
    recording_s3_prefix: ?[]const u8,

    /// The participant’s recording state.
    recording_state: ?ParticipantRecordingState,

    /// The participant's replication state.
    replication_state: ?ReplicationState,

    /// Indicates if the participant has been replicated to another stage or is a
    /// replica from another stage. Default: `NONE`.
    replication_type: ?ReplicationType,

    /// The participant’s SDK version.
    sdk_version: ?[]const u8,

    /// ID of the session within the source stage, if `replicationType` is
    /// `REPLICA`.
    source_session_id: ?[]const u8,

    /// Source stage ARN from which this participant is replicated, if
    /// `replicationType` is `REPLICA`.
    source_stage_arn: ?[]const u8,

    /// Whether the participant is connected to or disconnected from the stage.
    state: ?ParticipantState,

    /// Customer-assigned name to help identify the token; this can be used to link
    /// a
    /// participant to a user in the customer’s own systems. This can be any UTF-8
    /// encoded text.
    /// *This field is exposed to all stage participants and should not be used for
    /// personally identifying, confidential, or sensitive information*.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .browser_name = "browserName",
        .browser_version = "browserVersion",
        .first_join_time = "firstJoinTime",
        .isp_name = "ispName",
        .os_name = "osName",
        .os_version = "osVersion",
        .participant_id = "participantId",
        .protocol = "protocol",
        .published = "published",
        .recording_s3_bucket_name = "recordingS3BucketName",
        .recording_s3_prefix = "recordingS3Prefix",
        .recording_state = "recordingState",
        .replication_state = "replicationState",
        .replication_type = "replicationType",
        .sdk_version = "sdkVersion",
        .source_session_id = "sourceSessionId",
        .source_stage_arn = "sourceStageArn",
        .state = "state",
        .user_id = "userId",
    };
};
