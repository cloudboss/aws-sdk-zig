const MediaStreamAttributes = @import("media_stream_attributes.zig").MediaStreamAttributes;
const MediaStreamType = @import("media_stream_type.zig").MediaStreamType;

/// A media stream represents one component of your content, such as video,
/// audio, or ancillary data. After you add a media stream to your flow, you can
/// associate it with sources and outputs that use the ST 2110 JPEG XS or CDI
/// protocol.
pub const MediaStream = struct {
    /// Attributes that are related to the media stream.
    attributes: ?MediaStreamAttributes = null,

    /// The sample rate for the stream. This value is measured in Hz.
    clock_rate: ?i32 = null,

    /// A description that can help you quickly identify what your media stream is
    /// used for.
    description: ?[]const u8 = null,

    /// The format type number (sometimes referred to as RTP payload type) of the
    /// media stream. MediaConnect assigns this value to the media stream. For ST
    /// 2110 JPEG XS outputs, you need to provide this value to the receiver.
    fmt: i32,

    /// A unique identifier for the media stream.
    media_stream_id: i32,

    /// A name that helps you distinguish one media stream from another.
    media_stream_name: []const u8,

    /// The type of media stream.
    media_stream_type: MediaStreamType,

    /// The resolution of the video.
    video_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .clock_rate = "ClockRate",
        .description = "Description",
        .fmt = "Fmt",
        .media_stream_id = "MediaStreamId",
        .media_stream_name = "MediaStreamName",
        .media_stream_type = "MediaStreamType",
        .video_format = "VideoFormat",
    };
};
