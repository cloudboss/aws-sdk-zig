const Encryption = @import("encryption.zig").Encryption;
const OutputTimestampMode = @import("output_timestamp_mode.zig").OutputTimestampMode;
const Scte = @import("scte.zig").Scte;

/// The segment configuration, including the segment name, duration, and other
/// configuration values.
pub const Segment = struct {
    encryption: ?Encryption = null,

    /// When selected, the stream set includes an additional I-frame only stream,
    /// along with the other tracks. If false, this extra stream is not included.
    /// MediaPackage generates an I-frame only stream from the first rendition in
    /// the manifest. The service inserts EXT-I-FRAMES-ONLY tags in the output
    /// manifest, and then generates and includes an I-frames only playlist in the
    /// stream. This playlist permits player functionality like fast forward and
    /// rewind.
    include_iframe_only_streams: ?bool = null,

    /// The output timestamp mode for the origin endpoint's segments. This setting
    /// is only configurable on channels with `OutputLockingMode` set to
    /// `NON_EPOCH_LOCKED`. This value is immutable after endpoint creation. If you
    /// don't specify a value, the default is `PASSTHROUGH`.
    ///
    /// The allowed values are:
    ///
    /// * `PASSTHROUGH` - Output PTS (Presentation Timestamp) values pass through
    ///   unchanged from the input.
    /// * `REBASED_TO_CHANNEL_START` - Output PTS is rebased relative to the channel
    ///   start time.
    output_timestamp_mode: ?OutputTimestampMode = null,

    /// The SCTE configuration options in the segment settings.
    scte: ?Scte = null,

    /// The duration (in seconds) of each segment. Enter a value equal to, or a
    /// multiple of, the input segment duration. If the value that you enter is
    /// different from the input segment duration, MediaPackage rounds segments to
    /// the nearest multiple of the input segment duration.
    segment_duration_seconds: ?i32 = null,

    /// The name that describes the segment. The name is the base name of the
    /// segment used in all content manifests inside of the endpoint. You can't use
    /// spaces in the name.
    segment_name: ?[]const u8 = null,

    /// By default, MediaPackage excludes all digital video broadcasting (DVB)
    /// subtitles from the output. When selected, MediaPackage passes through DVB
    /// subtitles into the output.
    ts_include_dvb_subtitles: ?bool = null,

    /// When selected, MediaPackage bundles all audio tracks in a rendition group.
    /// All other tracks in the stream can be used with any audio rendition from the
    /// group.
    ts_use_audio_rendition_group: ?bool = null,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .include_iframe_only_streams = "IncludeIframeOnlyStreams",
        .output_timestamp_mode = "OutputTimestampMode",
        .scte = "Scte",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .segment_name = "SegmentName",
        .ts_include_dvb_subtitles = "TsIncludeDvbSubtitles",
        .ts_use_audio_rendition_group = "TsUseAudioRenditionGroup",
    };
};
