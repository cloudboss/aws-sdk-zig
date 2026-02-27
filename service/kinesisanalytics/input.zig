const InputParallelism = @import("input_parallelism.zig").InputParallelism;
const InputProcessingConfiguration = @import("input_processing_configuration.zig").InputProcessingConfiguration;
const SourceSchema = @import("source_schema.zig").SourceSchema;
const KinesisFirehoseInput = @import("kinesis_firehose_input.zig").KinesisFirehoseInput;
const KinesisStreamsInput = @import("kinesis_streams_input.zig").KinesisStreamsInput;

/// When you configure the application input, you specify the streaming source,
/// the
/// in-application stream name that is created, and the mapping between the two.
/// For more information,
/// see [Configuring Application
/// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
pub const Input = struct {
    /// Describes the number of in-application streams to create.
    ///
    /// Data from your source is routed to these in-application input streams.
    ///
    /// (see [Configuring Application
    /// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
    input_parallelism: ?InputParallelism,

    /// The
    /// [InputProcessingConfiguration](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputProcessingConfiguration.html) for the input. An input
    /// processor transforms records as they are received from the stream, before
    /// the
    /// application's SQL code executes. Currently, the only input processing
    /// configuration
    /// available is
    /// [InputLambdaProcessor](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/API_InputLambdaProcessor.html).
    input_processing_configuration: ?InputProcessingConfiguration,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns in the in-application stream that is
    /// being created.
    ///
    /// Also used to describe the format of the reference data source.
    input_schema: SourceSchema,

    /// If the streaming source is an Amazon Kinesis Firehose delivery stream,
    /// identifies
    /// the delivery stream's ARN and an IAM role that enables Amazon Kinesis
    /// Analytics to
    /// access the stream on your behalf.
    ///
    /// Note: Either `KinesisStreamsInput` or `KinesisFirehoseInput` is required.
    kinesis_firehose_input: ?KinesisFirehoseInput,

    /// If the streaming source is an Amazon Kinesis stream,
    /// identifies the stream's Amazon Resource Name (ARN) and an IAM role
    /// that enables Amazon Kinesis Analytics to access the stream on your behalf.
    ///
    /// Note: Either `KinesisStreamsInput` or `KinesisFirehoseInput` is required.
    kinesis_streams_input: ?KinesisStreamsInput,

    /// Name prefix to use when creating an in-application stream. Suppose that you
    /// specify
    /// a prefix "MyInApplicationStream." Amazon Kinesis Analytics then creates one
    /// or more (as
    /// per the `InputParallelism` count you specified) in-application streams with
    /// names "MyInApplicationStream_001," "MyInApplicationStream_002," and so on.
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
