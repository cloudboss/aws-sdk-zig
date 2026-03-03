const InputParallelismUpdate = @import("input_parallelism_update.zig").InputParallelismUpdate;
const InputProcessingConfigurationUpdate = @import("input_processing_configuration_update.zig").InputProcessingConfigurationUpdate;
const InputSchemaUpdate = @import("input_schema_update.zig").InputSchemaUpdate;
const KinesisFirehoseInputUpdate = @import("kinesis_firehose_input_update.zig").KinesisFirehoseInputUpdate;
const KinesisStreamsInputUpdate = @import("kinesis_streams_input_update.zig").KinesisStreamsInputUpdate;

/// For a SQL-based Kinesis Data Analytics application, describes updates to a
/// specific input configuration (identified by the `InputId` of an
/// application).
pub const InputUpdate = struct {
    /// The input ID of the application input to be updated.
    input_id: []const u8,

    /// Describes the parallelism updates (the number of in-application streams
    /// Kinesis Data Analytics creates for the specific streaming source).
    input_parallelism_update: ?InputParallelismUpdate = null,

    /// Describes updates to an InputProcessingConfiguration.
    input_processing_configuration_update: ?InputProcessingConfigurationUpdate = null,

    /// Describes the data format on the streaming source, and
    /// how record elements on the streaming source map to columns of the
    /// in-application stream that is created.
    input_schema_update: ?InputSchemaUpdate = null,

    /// If a Kinesis Data Firehose delivery stream is the streaming source to be
    /// updated, provides an updated stream ARN.
    kinesis_firehose_input_update: ?KinesisFirehoseInputUpdate = null,

    /// If a Kinesis data stream is the streaming source to be updated, provides an
    /// updated stream Amazon Resource Name (ARN).
    kinesis_streams_input_update: ?KinesisStreamsInputUpdate = null,

    /// The name prefix for in-application streams that Kinesis Data Analytics
    /// creates for the
    /// specific streaming source.
    name_prefix_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_id = "InputId",
        .input_parallelism_update = "InputParallelismUpdate",
        .input_processing_configuration_update = "InputProcessingConfigurationUpdate",
        .input_schema_update = "InputSchemaUpdate",
        .kinesis_firehose_input_update = "KinesisFirehoseInputUpdate",
        .kinesis_streams_input_update = "KinesisStreamsInputUpdate",
        .name_prefix_update = "NamePrefixUpdate",
    };
};
