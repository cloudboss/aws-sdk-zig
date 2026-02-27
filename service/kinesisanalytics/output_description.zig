const DestinationSchema = @import("destination_schema.zig").DestinationSchema;
const KinesisFirehoseOutputDescription = @import("kinesis_firehose_output_description.zig").KinesisFirehoseOutputDescription;
const KinesisStreamsOutputDescription = @import("kinesis_streams_output_description.zig").KinesisStreamsOutputDescription;
const LambdaOutputDescription = @import("lambda_output_description.zig").LambdaOutputDescription;

/// Describes the application output configuration, which includes
/// the in-application stream name and the destination where the stream data
/// is written. The destination can be an Amazon Kinesis stream or an
/// Amazon Kinesis Firehose delivery stream.
pub const OutputDescription = struct {
    /// Data format used for writing data to the destination.
    destination_schema: ?DestinationSchema,

    /// Describes the Amazon Kinesis Firehose delivery stream configured as the
    /// destination where output is written.
    kinesis_firehose_output_description: ?KinesisFirehoseOutputDescription,

    /// Describes Amazon Kinesis stream configured as the
    /// destination where output is written.
    kinesis_streams_output_description: ?KinesisStreamsOutputDescription,

    /// Describes the AWS Lambda function configured as the destination where output
    /// is
    /// written.
    lambda_output_description: ?LambdaOutputDescription,

    /// Name of the in-application stream configured as output.
    name: ?[]const u8,

    /// A unique identifier for the output configuration.
    output_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_schema = "DestinationSchema",
        .kinesis_firehose_output_description = "KinesisFirehoseOutputDescription",
        .kinesis_streams_output_description = "KinesisStreamsOutputDescription",
        .lambda_output_description = "LambdaOutputDescription",
        .name = "Name",
        .output_id = "OutputId",
    };
};
