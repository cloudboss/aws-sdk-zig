const ParticipantRecordingHlsConfiguration = @import("participant_recording_hls_configuration.zig").ParticipantRecordingHlsConfiguration;
const ParticipantRecordingMediaType = @import("participant_recording_media_type.zig").ParticipantRecordingMediaType;
const ParticipantThumbnailConfiguration = @import("participant_thumbnail_configuration.zig").ParticipantThumbnailConfiguration;

/// Object specifying a configuration for individual participant recording.
pub const AutoParticipantRecordingConfiguration = struct {
    /// HLS configuration object for individual participant recording.
    hls_configuration: ?ParticipantRecordingHlsConfiguration,

    /// Types of media to be recorded. Default: `AUDIO_VIDEO`.
    media_types: ?[]const ParticipantRecordingMediaType,

    /// If a stage publisher disconnects and then reconnects within the specified
    /// interval,
    /// the multiple recordings will be considered a single recording and merged
    /// together.
    ///
    /// The default value is 0, which disables merging.
    recording_reconnect_window_seconds: i32 = 0,

    /// Optional field to disable replica participant recording. If this is set to
    /// `false` when a
    /// participant is a replica, replica participants are not recorded. Default:
    /// `true`.
    record_participant_replicas: bool = false,

    /// ARN of the StorageConfiguration resource to use for individual
    /// participant recording. Default: `""` (empty string, no storage configuration
    /// is
    /// specified). Individual participant recording cannot be started unless a
    /// storage
    /// configuration is specified, when a Stage is created or updated. To
    /// disable individual participant recording, set this to `""`; other fields in
    /// this object will
    /// get reset to their defaults when sending `""`.
    storage_configuration_arn: []const u8,

    /// A complex type that allows you to enable/disable the recording of thumbnails
    /// for
    /// individual participant recording and modify the interval at which thumbnails
    /// are generated
    /// for the live session.
    thumbnail_configuration: ?ParticipantThumbnailConfiguration,

    pub const json_field_names = .{
        .hls_configuration = "hlsConfiguration",
        .media_types = "mediaTypes",
        .recording_reconnect_window_seconds = "recordingReconnectWindowSeconds",
        .record_participant_replicas = "recordParticipantReplicas",
        .storage_configuration_arn = "storageConfigurationArn",
        .thumbnail_configuration = "thumbnailConfiguration",
    };
};
