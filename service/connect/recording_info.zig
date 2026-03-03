const MediaStreamType = @import("media_stream_type.zig").MediaStreamType;
const ParticipantType = @import("participant_type.zig").ParticipantType;
const RecordingStatus = @import("recording_status.zig").RecordingStatus;
const StorageType = @import("storage_type.zig").StorageType;

/// Information about a voice recording, chat transcript, or screen recording.
pub const RecordingInfo = struct {
    /// If the recording/transcript was deleted, this is the reason entered for the
    /// deletion.
    deletion_reason: ?[]const u8 = null,

    /// The number that identifies the Kinesis Video Streams fragment where the
    /// customer audio stream started.
    fragment_start_number: ?[]const u8 = null,

    /// The number that identifies the Kinesis Video Streams fragment where the
    /// customer audio stream stopped.
    fragment_stop_number: ?[]const u8 = null,

    /// The location, in Amazon S3, for the recording/transcript.
    location: ?[]const u8 = null,

    /// Information about the media stream used during the conversation.
    media_stream_type: ?MediaStreamType = null,

    /// Information about the conversation participant, whether they are an agent or
    /// contact. The participant types are
    /// as follows:
    ///
    /// * All
    ///
    /// * Manager
    ///
    /// * Agent
    ///
    /// * Customer
    ///
    /// * Thirdparty
    ///
    /// * Supervisor
    participant_type: ?ParticipantType = null,

    /// When the conversation of the last leg of the recording started in UTC time.
    start_timestamp: ?i64 = null,

    /// The status of the recording/transcript.
    status: ?RecordingStatus = null,

    /// When the conversation of the last leg of recording stopped in UTC time.
    stop_timestamp: ?i64 = null,

    /// Where the recording/transcript is stored.
    storage_type: ?StorageType = null,

    /// The location, in Amazon S3, for the unprocessed transcript if any media
    /// processing was performed.
    unprocessed_transcript_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .deletion_reason = "DeletionReason",
        .fragment_start_number = "FragmentStartNumber",
        .fragment_stop_number = "FragmentStopNumber",
        .location = "Location",
        .media_stream_type = "MediaStreamType",
        .participant_type = "ParticipantType",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
        .stop_timestamp = "StopTimestamp",
        .storage_type = "StorageType",
        .unprocessed_transcript_location = "UnprocessedTranscriptLocation",
    };
};
