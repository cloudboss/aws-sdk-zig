const InputParallelism = @import("input_parallelism.zig").InputParallelism;
const InputProcessingConfiguration = @import("input_processing_configuration.zig").InputProcessingConfiguration;
const SourceSchema = @import("source_schema.zig").SourceSchema;
const KinesisFirehoseInput = @import("kinesis_firehose_input.zig").KinesisFirehoseInput;
const KinesisStreamsInput = @import("kinesis_streams_input.zig").KinesisStreamsInput;

/// When you configure the application input for a SQL-based Kinesis Data
/// Analytics application, you specify the streaming source, the in-application
/// stream
/// name that is created,
/// and the mapping between the two.
pub const Input = struct {
    /// Describes the number of in-application streams to create.
    input_parallelism: ?InputParallelism = null,

    /// The InputProcessingConfiguration for the input. An input processor
    /// transforms records as they are received
    /// from the stream, before the application's SQL code executes. Currently, the
    /// only input processing configuration available is
    /// InputLambdaProcessor.
    input_processing_configuration: ?InputProcessingConfiguration = null,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps
    /// to corresponding columns in the in-application stream that is being created.
    ///
    /// Also used to describe the format of the reference data source.
    input_schema: SourceSchema,

    /// If the streaming source is an Amazon Kinesis Data Firehose delivery stream,
    /// identifies the delivery stream's ARN.
    kinesis_firehose_input: ?KinesisFirehoseInput = null,

    /// If the streaming source is an Amazon Kinesis data stream, identifies the
    /// stream's Amazon Resource Name (ARN).
    kinesis_streams_input: ?KinesisStreamsInput = null,

    /// The name prefix to use when creating an in-application stream. Suppose that
    /// you specify a
    /// prefix "`MyInApplicationStream`." Kinesis Data Analytics then creates one or
    /// more
    /// (as per the `InputParallelism` count you specified) in-application streams
    /// with the
    /// names "`MyInApplicationStream_001`," "`MyInApplicationStream_002`," and
    /// so on.
    name_prefix: []const u8,

    pub const json_field_names = .{
        .input_parallelism = "InputParallelism",
        .input_processing_configuration = "InputProcessingConfiguration",
        .input_schema = "InputSchema",
        .kinesis_firehose_input = "KinesisFirehoseInput",
        .kinesis_streams_input = "KinesisStreamsInput",
        .name_prefix = "NamePrefix",
    };
};
