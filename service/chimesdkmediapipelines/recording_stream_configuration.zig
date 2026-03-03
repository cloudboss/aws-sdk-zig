/// A structure that holds the settings for recording media.
pub const RecordingStreamConfiguration = struct {
    /// The ARN of the recording stream.
    stream_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .stream_arn = "StreamArn",
    };
};
