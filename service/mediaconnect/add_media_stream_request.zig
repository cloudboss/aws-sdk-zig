const aws = @import("aws");

const MediaStreamAttributesRequest = @import("media_stream_attributes_request.zig").MediaStreamAttributesRequest;
const MediaStreamType = @import("media_stream_type.zig").MediaStreamType;

/// The media stream that you want to add to the flow.
pub const AddMediaStreamRequest = struct {
    /// The attributes that you want to assign to the new media stream.
    attributes: ?MediaStreamAttributesRequest = null,

    /// The sample rate (in Hz) for the stream. If the media stream type is video or
    /// ancillary data, set this value to 90000. If the media stream type is audio,
    /// set this value to either 48000 or 96000.
    clock_rate: ?i32 = null,

    /// A description that can help you quickly identify what your media stream is
    /// used for.
    description: ?[]const u8 = null,

    /// A unique identifier for the media stream.
    media_stream_id: i32,

    /// A name that helps you distinguish one media stream from another.
    media_stream_name: []const u8,

    /// The key-value pairs that can be used to tag and organize the media stream.
    media_stream_tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of media stream.
    media_stream_type: MediaStreamType,

    /// The resolution of the video.
    video_format: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .clock_rate = "ClockRate",
        .description = "Description",
        .media_stream_id = "MediaStreamId",
        .media_stream_name = "MediaStreamName",
        .media_stream_tags = "MediaStreamTags",
        .media_stream_type = "MediaStreamType",
        .video_format = "VideoFormat",
    };
};
