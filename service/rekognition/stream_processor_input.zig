const KinesisVideoStream = @import("kinesis_video_stream.zig").KinesisVideoStream;

/// Information about the source streaming video.
pub const StreamProcessorInput = struct {
    /// The Kinesis video stream input stream for the source streaming video.
    kinesis_video_stream: ?KinesisVideoStream,

    pub const json_field_names = .{
        .kinesis_video_stream = "KinesisVideoStream",
    };
};
