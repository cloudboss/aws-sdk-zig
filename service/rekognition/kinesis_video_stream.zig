/// Kinesis video stream stream that provides the source streaming video for a
/// Amazon Rekognition Video stream processor. For more information, see
/// CreateStreamProcessor in the Amazon Rekognition Developer Guide.
pub const KinesisVideoStream = struct {
    /// ARN of the Kinesis video stream stream that streams the source video.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
