/// The Kinesis data stream Amazon Rekognition to which the analysis results of
/// a Amazon Rekognition stream processor are streamed. For more information,
/// see
/// CreateStreamProcessor in the Amazon Rekognition Developer Guide.
pub const KinesisDataStream = struct {
    /// ARN of the output Amazon Kinesis Data Streams stream.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};
