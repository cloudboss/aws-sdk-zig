const InputParallelism = @import("input_parallelism.zig").InputParallelism;
const InputProcessingConfigurationDescription = @import("input_processing_configuration_description.zig").InputProcessingConfigurationDescription;
const SourceSchema = @import("source_schema.zig").SourceSchema;
const InputStartingPositionConfiguration = @import("input_starting_position_configuration.zig").InputStartingPositionConfiguration;
const KinesisFirehoseInputDescription = @import("kinesis_firehose_input_description.zig").KinesisFirehoseInputDescription;
const KinesisStreamsInputDescription = @import("kinesis_streams_input_description.zig").KinesisStreamsInputDescription;

/// Describes the application input configuration for a SQL-based Kinesis Data
/// Analytics application.
pub const InputDescription = struct {
    /// Returns the in-application stream names that are mapped to the stream
    /// source.
    in_app_stream_names: ?[]const []const u8,

    /// The input ID that is associated with the application input. This is the ID
    /// that Kinesis Data Analytics assigns to each input
    /// configuration that you add to your application.
    input_id: ?[]const u8,

    /// Describes the configured parallelism (number of in-application streams
    /// mapped to the streaming source).
    input_parallelism: ?InputParallelism,

    /// The description of the preprocessor that executes on records in this input
    /// before the application's code is run.
    input_processing_configuration_description: ?InputProcessingConfigurationDescription,

    /// Describes the format of the data in the streaming source, and how each data
    /// element maps to corresponding columns
    /// in the in-application stream that is being created.
    input_schema: ?SourceSchema,

    /// The point at which the application is configured to read from the input
    /// stream.
    input_starting_position_configuration: ?InputStartingPositionConfiguration,

    /// If a Kinesis Data Firehose delivery stream is configured as a streaming
    /// source, provides the delivery stream's ARN.
    kinesis_firehose_input_description: ?KinesisFirehoseInputDescription,

    /// If a Kinesis data stream is configured as a streaming source, provides the
    /// Kinesis data
    /// stream's Amazon Resource Name (ARN).
    kinesis_streams_input_description: ?KinesisStreamsInputDescription,

    /// The in-application name prefix.
    name_prefix: ?[]const u8,

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
