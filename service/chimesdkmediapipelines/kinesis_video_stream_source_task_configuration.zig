/// The task configuration settings for the Kinesis video stream source.
pub const KinesisVideoStreamSourceTaskConfiguration = struct {
    /// The channel ID.
    channel_id: i32 = 0,

    /// The unique identifier of the fragment to begin processing.
    fragment_number: ?[]const u8 = null,

    /// The ARN of the stream.
    stream_arn: []const u8,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .fragment_number = "FragmentNumber",
        .stream_arn = "StreamArn",
    };
};
