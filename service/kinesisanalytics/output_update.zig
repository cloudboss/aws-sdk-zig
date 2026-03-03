const DestinationSchema = @import("destination_schema.zig").DestinationSchema;
const KinesisFirehoseOutputUpdate = @import("kinesis_firehose_output_update.zig").KinesisFirehoseOutputUpdate;
const KinesisStreamsOutputUpdate = @import("kinesis_streams_output_update.zig").KinesisStreamsOutputUpdate;
const LambdaOutputUpdate = @import("lambda_output_update.zig").LambdaOutputUpdate;

/// Describes updates to the output configuration identified by
/// the `OutputId`.
pub const OutputUpdate = struct {
    /// Describes the data format when records are written to the destination. For
    /// more information, see [Configuring Application
    /// Output](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-output.html).
    destination_schema_update: ?DestinationSchema = null,

    /// Describes an Amazon Kinesis Firehose delivery stream as the destination for
    /// the
    /// output.
    kinesis_firehose_output_update: ?KinesisFirehoseOutputUpdate = null,

    /// Describes an Amazon Kinesis stream as the destination for the output.
    kinesis_streams_output_update: ?KinesisStreamsOutputUpdate = null,

    /// Describes an AWS Lambda function as the destination for the output.
    lambda_output_update: ?LambdaOutputUpdate = null,

    /// If you want to specify a different in-application stream
    /// for this output configuration, use this field to
    /// specify the new in-application stream name.
    name_update: ?[]const u8 = null,

    /// Identifies the specific output configuration that you want to update.
    output_id: []const u8,

    pub const json_field_names = .{
        .destination_schema_update = "DestinationSchemaUpdate",
        .kinesis_firehose_output_update = "KinesisFirehoseOutputUpdate",
        .kinesis_streams_output_update = "KinesisStreamsOutputUpdate",
        .lambda_output_update = "LambdaOutputUpdate",
        .name_update = "NameUpdate",
        .output_id = "OutputId",
    };
};
