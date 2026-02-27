const FrameResolution = @import("frame_resolution.zig").FrameResolution;
const ScanMode = @import("scan_mode.zig").ScanMode;

/// Detailed information about a single media stream that is part of an NDI®
/// source. This includes details about the stream type, codec, resolution,
/// frame rate, audio channels, and sample rate.
pub const NdiMediaStreamInfo = struct {
    /// The number of audio channels in the stream. Used when the `streamType` is
    /// `Audio`.
    channels: ?i32,

    /// The codec used for the media stream. For NDI sources, use `speed-hq`.
    codec: []const u8,

    /// The number of video frames displayed per second. Used when the `streamType`
    /// is `Video`.
    frame_rate: ?[]const u8,

    /// The width and height dimensions of the video frame in pixels. Used when the
    /// `streamType` is `Video`.
    frame_resolution: ?FrameResolution,

    /// The number of audio samples captured per second, measured in kilohertz
    /// (kHz). Used when the `streamType` is `Audio`.
    sample_rate: ?i32,

    /// The method used to display video frames. Used when the `streamType` is
    /// `Video`.
    scan_mode: ?ScanMode,

    /// A unique identifier for the media stream.
    stream_id: i32,

    /// The type of media stream (for example, `Video` or `Audio`).
    stream_type: []const u8,

    pub const json_field_names = .{
        .channels = "Channels",
        .codec = "Codec",
        .frame_rate = "FrameRate",
        .frame_resolution = "FrameResolution",
        .sample_rate = "SampleRate",
        .scan_mode = "ScanMode",
        .stream_id = "StreamId",
        .stream_type = "StreamType",
    };
};
