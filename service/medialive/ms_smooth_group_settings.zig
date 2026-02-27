const SmoothGroupAudioOnlyTimecodeControl = @import("smooth_group_audio_only_timecode_control.zig").SmoothGroupAudioOnlyTimecodeControl;
const SmoothGroupCertificateMode = @import("smooth_group_certificate_mode.zig").SmoothGroupCertificateMode;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const SmoothGroupEventIdMode = @import("smooth_group_event_id_mode.zig").SmoothGroupEventIdMode;
const SmoothGroupEventStopBehavior = @import("smooth_group_event_stop_behavior.zig").SmoothGroupEventStopBehavior;
const InputLossActionForMsSmoothOut = @import("input_loss_action_for_ms_smooth_out.zig").InputLossActionForMsSmoothOut;
const SmoothGroupSegmentationMode = @import("smooth_group_segmentation_mode.zig").SmoothGroupSegmentationMode;
const SmoothGroupSparseTrackType = @import("smooth_group_sparse_track_type.zig").SmoothGroupSparseTrackType;
const SmoothGroupStreamManifestBehavior = @import("smooth_group_stream_manifest_behavior.zig").SmoothGroupStreamManifestBehavior;
const SmoothGroupTimestampOffsetMode = @import("smooth_group_timestamp_offset_mode.zig").SmoothGroupTimestampOffsetMode;

/// Ms Smooth Group Settings
pub const MsSmoothGroupSettings = struct {
    /// The ID to include in each message in the sparse track. Ignored if
    /// sparseTrackType is NONE.
    acquisition_point_id: ?[]const u8,

    /// If set to passthrough for an audio-only MS Smooth output, the fragment
    /// absolute time will be set to the current timecode. This option does not
    /// write timecodes to the audio elementary stream.
    audio_only_timecode_control: ?SmoothGroupAudioOnlyTimecodeControl,

    /// If set to verifyAuthenticity, verify the https certificate chain to a
    /// trusted Certificate Authority (CA). This will cause https outputs to
    /// self-signed certificates to fail.
    certificate_mode: ?SmoothGroupCertificateMode,

    /// Number of seconds to wait before retrying connection to the IIS server if
    /// the connection is lost. Content will be cached during this time and the
    /// cache will be be delivered to the IIS server once the connection is
    /// re-established.
    connection_retry_interval: ?i32,

    /// Smooth Streaming publish point on an IIS server. Elemental Live acts as a
    /// "Push" encoder to IIS.
    destination: OutputLocationRef,

    /// MS Smooth event ID to be sent to the IIS server.
    ///
    /// Should only be specified if eventIdMode is set to useConfigured.
    event_id: ?[]const u8,

    /// Specifies whether or not to send an event ID to the IIS server. If no event
    /// ID is sent and the same Live Event is used without changing the publishing
    /// point, clients might see cached video from the previous run.
    ///
    /// Options:
    /// - "useConfigured" - use the value provided in eventId
    /// - "useTimestamp" - generate and send an event ID based on the current
    /// timestamp
    /// - "noEventId" - do not send an event ID to the IIS server.
    event_id_mode: ?SmoothGroupEventIdMode,

    /// When set to sendEos, send EOS signal to IIS server when stopping the event
    event_stop_behavior: ?SmoothGroupEventStopBehavior,

    /// Size in seconds of file cache for streaming outputs.
    filecache_duration: ?i32,

    /// Length of mp4 fragments to generate (in seconds). Fragment length must be
    /// compatible with GOP size and framerate.
    fragment_length: ?i32,

    /// Parameter that control output group behavior on input loss.
    input_loss_action: ?InputLossActionForMsSmoothOut,

    /// Number of retry attempts.
    num_retries: ?i32,

    /// Number of seconds before initiating a restart due to output failure, due to
    /// exhausting the numRetries on one segment, or exceeding filecacheDuration.
    restart_delay: ?i32,

    /// useInputSegmentation has been deprecated. The configured segment size is
    /// always used.
    segmentation_mode: ?SmoothGroupSegmentationMode,

    /// Number of milliseconds to delay the output from the second pipeline.
    send_delay_ms: ?i32,

    /// Identifies the type of data to place in the sparse track:
    /// - SCTE35: Insert SCTE-35 messages from the source content. With each
    /// message, insert an IDR frame to start a new segment.
    /// - SCTE35_WITHOUT_SEGMENTATION: Insert SCTE-35 messages from the source
    /// content. With each message, insert an IDR frame but don't start a new
    /// segment.
    /// - NONE: Don't generate a sparse track for any outputs in this output group.
    sparse_track_type: ?SmoothGroupSparseTrackType,

    /// When set to send, send stream manifest so publishing point doesn't start
    /// until all streams start.
    stream_manifest_behavior: ?SmoothGroupStreamManifestBehavior,

    /// Timestamp offset for the event. Only used if timestampOffsetMode is set to
    /// useConfiguredOffset.
    timestamp_offset: ?[]const u8,

    /// Type of timestamp date offset to use.
    /// - useEventStartDate: Use the date the event was started as the offset
    /// - useConfiguredOffset: Use an explicitly configured date as the offset
    timestamp_offset_mode: ?SmoothGroupTimestampOffsetMode,

    pub const json_field_names = .{
        .acquisition_point_id = "AcquisitionPointId",
        .audio_only_timecode_control = "AudioOnlyTimecodeControl",
        .certificate_mode = "CertificateMode",
        .connection_retry_interval = "ConnectionRetryInterval",
        .destination = "Destination",
        .event_id = "EventId",
        .event_id_mode = "EventIdMode",
        .event_stop_behavior = "EventStopBehavior",
        .filecache_duration = "FilecacheDuration",
        .fragment_length = "FragmentLength",
        .input_loss_action = "InputLossAction",
        .num_retries = "NumRetries",
        .restart_delay = "RestartDelay",
        .segmentation_mode = "SegmentationMode",
        .send_delay_ms = "SendDelayMs",
        .sparse_track_type = "SparseTrackType",
        .stream_manifest_behavior = "StreamManifestBehavior",
        .timestamp_offset = "TimestampOffset",
        .timestamp_offset_mode = "TimestampOffsetMode",
    };
};
