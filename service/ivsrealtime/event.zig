const EventErrorCode = @import("event_error_code.zig").EventErrorCode;
const EventName = @import("event_name.zig").EventName;
const ExchangedParticipantToken = @import("exchanged_participant_token.zig").ExchangedParticipantToken;

/// An occurrence during a stage session.
pub const Event = struct {
    /// ID of the session within the destination stage. Applicable only if the event
    /// name is
    /// `REPLICATION_STARTED` or `REPLICATION_STOPPED`.
    destination_session_id: ?[]const u8 = null,

    /// ARN of the stage where the participant is replicated. Applicable only if the
    /// event name is
    /// `REPLICATION_STARTED` or `REPLICATION_STOPPED`.
    destination_stage_arn: ?[]const u8 = null,

    /// If the event is an error event, the error code is provided to give insight
    /// into the
    /// specific error that occurred. If the event is not an error event, this field
    /// is
    /// null.
    ///
    /// * `B_FRAME_PRESENT` — The participant's stream includes B-frames.
    /// For details, see [ IVS RTMP
    /// Publishing](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/rt-rtmp-publishing.html).
    ///
    /// * `BITRATE_EXCEEDED` — The participant exceeded the maximum
    /// supported bitrate. For details, see [ Service
    /// Quotas](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/service-quotas.html).
    ///
    /// * `INSUFFICIENT_CAPABILITIES` — The participant tried to take an
    /// action that the participant’s token is not allowed to do. For details on
    /// participant
    /// capabilities, see the `capabilities` field in CreateParticipantToken.
    ///
    /// * `INTERNAL_SERVER_EXCEPTION` — The participant failed to publish
    /// to the stage due to an internal server error.
    ///
    /// * `INVALID_AUDIO_CODEC` — The participant is using an invalid audio
    /// codec. For details, see [ Stream
    /// Ingest](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/rt-stream-ingest.html).
    ///
    /// * `INVALID_INPUT` — The participant is using an invalid input
    /// stream.
    ///
    /// * `INVALID_PROTOCOL` — The participant's IngestConfiguration
    /// resource is configured for RTMPS but they tried streaming with RTMP. For
    /// details, see
    /// [ IVS RTMP
    /// Publishing](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/rt-rtmp-publishing.html).
    ///
    /// * `INVALID_STREAM_KEY` — The participant is using an invalid stream
    /// key. For details, see [ IVS RTMP
    /// Publishing](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/rt-rtmp-publishing.html).
    ///
    /// * `INVALID_VIDEO_CODEC` — The participant is using an invalid video
    /// codec. For details, see [ Stream
    /// Ingest](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/rt-stream-ingest.html).
    ///
    /// * `PUBLISHER_NOT_FOUND` — The participant tried to subscribe to a
    /// publisher that doesn’t exist.
    ///
    /// * `QUOTA_EXCEEDED` — The number of participants who want to
    /// publish/subscribe to a stage exceeds the quota. For details, see [
    /// Service
    /// Quotas](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/service-quotas.html).
    ///
    /// * `RESOLUTION_EXCEEDED` — The participant exceeded the maximum
    /// supported resolution. For details, see [ Service
    /// Quotas](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/service-quotas.html).
    ///
    /// * `REUSE_OF_STREAM_KEY` — The participant tried to use a stream key
    /// that is associated with another active stage session.
    ///
    /// * `STREAM_DURATION_EXCEEDED` — The participant exceeded the maximum
    /// allowed stream duration. For details, see [ Service
    /// Quotas](https://docs.aws.amazon.com/ivs/latest/RealTimeUserGuide/service-quotas.html).
    error_code: ?EventErrorCode = null,

    /// ISO 8601 timestamp (returned as a string) for when the event occurred.
    event_time: ?i64 = null,

    /// The name of the event.
    name: ?EventName = null,

    /// Participant token created during `TOKEN_EXCHANGED` event.
    new_token: ?ExchangedParticipantToken = null,

    /// Unique identifier for the participant who triggered the event. This is
    /// assigned by
    /// IVS.
    participant_id: ?[]const u8 = null,

    /// Source participant token for `TOKEN_EXCHANGED` event.
    previous_token: ?ExchangedParticipantToken = null,

    /// Unique identifier for the remote participant. For a subscribe event, this is
    /// the
    /// publisher. For a publish or join event, this is null. This is assigned by
    /// IVS.
    remote_participant_id: ?[]const u8 = null,

    /// If true, this indicates the `participantId` is a replicated participant.
    /// If this is a subscribe event, then this flag refers to
    /// `remoteParticipantId`. Default: `false`.
    replica: bool = false,

    pub const json_field_names = .{
        .destination_session_id = "destinationSessionId",
        .destination_stage_arn = "destinationStageArn",
        .error_code = "errorCode",
        .event_time = "eventTime",
        .name = "name",
        .new_token = "newToken",
        .participant_id = "participantId",
        .previous_token = "previousToken",
        .remote_participant_id = "remoteParticipantId",
        .replica = "replica",
    };
};
