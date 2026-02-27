const DestinationSchema = @import("destination_schema.zig").DestinationSchema;
const KinesisFirehoseOutput = @import("kinesis_firehose_output.zig").KinesisFirehoseOutput;
const KinesisStreamsOutput = @import("kinesis_streams_output.zig").KinesisStreamsOutput;
const LambdaOutput = @import("lambda_output.zig").LambdaOutput;

/// Describes application output configuration in which you identify
/// an in-application stream and a destination where you want the
/// in-application stream data to be written. The destination can be
/// an Amazon Kinesis stream or an Amazon Kinesis Firehose delivery stream.
///
/// For limits on how many destinations an application can write and other
/// limitations, see
/// [Limits](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/limits.html).
pub const Output = struct {
    /// Describes the data format when records are written to the destination. For
    /// more information, see [Configuring Application
    /// Output](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-output.html).
    destination_schema: DestinationSchema,

    /// Identifies an Amazon Kinesis Firehose delivery stream as the destination.
    kinesis_firehose_output: ?KinesisFirehoseOutput,

    /// Identifies an Amazon Kinesis stream
    /// as the destination.
    kinesis_streams_output: ?KinesisStreamsOutput,

    /// Identifies an AWS Lambda function as the destination.
    lambda_output: ?LambdaOutput,

    /// Name of the in-application stream.
    name: []const u8,

    pub const json_field_names = .{
        .destination_schema = "DestinationSchema",
        .kinesis_firehose_output = "KinesisFirehoseOutput",
        .kinesis_streams_output = "KinesisStreamsOutput",
        .lambda_output = "LambdaOutput",
        .name = "Name",
    };
};
