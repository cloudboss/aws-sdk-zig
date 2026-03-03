const FrameResolution = @import("frame_resolution.zig").FrameResolution;

/// The metadata of an elementary transport stream.
pub const TransportStream = struct {
    /// The number of channels in the audio stream.
    channels: ?i32 = null,

    /// The codec used by the stream.
    codec: ?[]const u8 = null,

    /// The frame rate used by the video stream.
    frame_rate: ?[]const u8 = null,

    /// The frame resolution used by the video stream.
    frame_resolution: ?FrameResolution = null,

    /// The Packet ID (PID) as it is reported in the Program Map Table.
    pid: i32,

    /// The sample rate used by the audio stream.
    sample_rate: ?i32 = null,

    /// The sample bit size used by the audio stream.
    sample_size: ?i32 = null,

    /// The Stream Type as it is reported in the Program Map Table.
    stream_type: []const u8,

    pub const json_field_names = .{
        .channels = "Channels",
        .codec = "Codec",
        .frame_rate = "FrameRate",
        .frame_resolution = "FrameResolution",
        .pid = "Pid",
        .sample_rate = "SampleRate",
        .sample_size = "SampleSize",
        .stream_type = "StreamType",
    };
};
