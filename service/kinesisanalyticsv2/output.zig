const DestinationSchema = @import("destination_schema.zig").DestinationSchema;
const KinesisFirehoseOutput = @import("kinesis_firehose_output.zig").KinesisFirehoseOutput;
const KinesisStreamsOutput = @import("kinesis_streams_output.zig").KinesisStreamsOutput;
const LambdaOutput = @import("lambda_output.zig").LambdaOutput;

/// Describes a SQL-based Kinesis Data Analytics application's output
/// configuration,
/// in which you identify an in-application stream and a destination where you
/// want the
/// in-application stream data to be written. The destination can be a Kinesis
/// data stream or a
/// Kinesis Data Firehose delivery stream.
pub const Output = struct {
    /// Describes the data format when records are written to the destination.
    destination_schema: DestinationSchema,

    /// Identifies a Kinesis Data Firehose delivery stream as the destination.
    kinesis_firehose_output: ?KinesisFirehoseOutput = null,

    /// Identifies a Kinesis data stream
    /// as the destination.
    kinesis_streams_output: ?KinesisStreamsOutput = null,

    /// Identifies an Amazon Lambda function as the destination.
    lambda_output: ?LambdaOutput = null,

    /// The name of the in-application stream.
    name: []const u8,

    pub const json_field_names = .{
        .destination_schema = "DestinationSchema",
        .kinesis_firehose_output = "KinesisFirehoseOutput",
        .kinesis_streams_output = "KinesisStreamsOutput",
        .lambda_output = "LambdaOutput",
        .name = "Name",
    };
};
