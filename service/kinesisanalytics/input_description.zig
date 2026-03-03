const InputParallelism = @import("input_parallelism.zig").InputParallelism;
const InputProcessingConfigurationDescription = @import("input_processing_configuration_description.zig").InputProcessingConfigurationDescription;
const SourceSchema = @import("source_schema.zig").SourceSchema;
const InputStartingPositionConfiguration = @import("input_starting_position_configuration.zig").InputStartingPositionConfiguration;
const KinesisFirehoseInputDescription = @import("kinesis_firehose_input_description.zig").KinesisFirehoseInputDescription;
const KinesisStreamsInputDescription = @import("kinesis_streams_input_description.zig").KinesisStreamsInputDescription;

/// Describes the application input configuration.
/// For more information,
/// see [Configuring Application
/// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
pub const InputDescription = struct {
    /// Returns the in-application stream names that are mapped to the
    /// stream source.
    in_app_stream_names: ?[]const []const u8 = null,

    /// Input ID associated with the application input.
    /// This is the ID that Amazon Kinesis Analytics assigns to each
    /// input configuration you add to your application.
    input_id: ?[]const u8 = null,

    /// Describes the configured parallelism (number of in-application streams
    /// mapped to the streaming source).
    input_parallelism: ?InputParallelism = null,

    /// The description of the preprocessor that executes on records in this input
    /// before the application's code is run.
    input_processing_configuration_description: ?InputProcessingConfigurationDescription = null,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding
    /// columns in the in-application stream that is being created.
    input_schema: ?SourceSchema = null,

    /// Point at which the application is configured to read from the input stream.
    input_starting_position_configuration: ?InputStartingPositionConfiguration = null,

    /// If an Amazon Kinesis Firehose delivery stream is configured as a streaming
    /// source,
    /// provides the delivery stream's ARN and an IAM role that enables Amazon
    /// Kinesis Analytics
    /// to access the stream on your behalf.
    kinesis_firehose_input_description: ?KinesisFirehoseInputDescription = null,

    /// If an Amazon Kinesis stream is configured as streaming source, provides
    /// Amazon
    /// Kinesis stream's Amazon Resource Name (ARN) and an IAM role that enables
    /// Amazon Kinesis
    /// Analytics to access the stream on your behalf.
    kinesis_streams_input_description: ?KinesisStreamsInputDescription = null,

    /// In-application name prefix.
    name_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .in_app_stream_names = "InAppStreamNames",
        .input_id = "InputId",
        .input_parallelism = "InputParallelism",
        .input_processing_configuration_description = "InputProcessingConfigurationDescription",
        .input_schema = "InputSchema",
        .input_starting_position_configuration = "InputStartingPositionConfiguration",
        .kinesis_firehose_input_description = "KinesisFirehoseInputDescription",
        .kinesis_streams_input_description = "KinesisStreamsInputDescription",
        .name_prefix = "NamePrefix",
    };
};
