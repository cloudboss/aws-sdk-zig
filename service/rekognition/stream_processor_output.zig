const KinesisDataStream = @import("kinesis_data_stream.zig").KinesisDataStream;
const S3Destination = @import("s3_destination.zig").S3Destination;

/// Information about the Amazon Kinesis Data Streams stream to which a Amazon
/// Rekognition Video stream processor streams the results of a video analysis.
/// For more
/// information, see CreateStreamProcessor in the Amazon Rekognition Developer
/// Guide.
pub const StreamProcessorOutput = struct {
    /// The Amazon Kinesis Data Streams stream to which the Amazon Rekognition
    /// stream processor streams the analysis results.
    kinesis_data_stream: ?KinesisDataStream = null,

    /// The Amazon S3 bucket location to which Amazon Rekognition publishes the
    /// detailed inference results of a video analysis operation.
    s3_destination: ?S3Destination = null,

    pub const json_field_names = .{
        .kinesis_data_stream = "KinesisDataStream",
        .s3_destination = "S3Destination",
    };
};
