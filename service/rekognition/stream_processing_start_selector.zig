const KinesisVideoStreamStartSelector = @import("kinesis_video_stream_start_selector.zig").KinesisVideoStreamStartSelector;

/// This is a required parameter for label detection stream processors and
/// should not be used
/// to start a face search stream processor.
pub const StreamProcessingStartSelector = struct {
    /// Specifies the starting point in the stream to start processing. This can be
    /// done with a producer timestamp or a fragment number in a Kinesis stream.
    kvs_stream_start_selector: ?KinesisVideoStreamStartSelector = null,

    pub const json_field_names = .{
        .kvs_stream_start_selector = "KVSStreamStartSelector",
    };
};
