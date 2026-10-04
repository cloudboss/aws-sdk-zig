const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const ChannelEncryptionConfiguration = @import("channel_encryption_configuration.zig").ChannelEncryptionConfiguration;
const ChannelLoggingConfiguration = @import("channel_logging_configuration.zig").ChannelLoggingConfiguration;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const S3TablesDestinationDescription = @import("s3_tables_destination_description.zig").S3TablesDestinationDescription;
const ChannelStreamDescription = @import("channel_stream_description.zig").ChannelStreamDescription;

/// Describes the configuration and current status of a channel.
pub const ChannelDescription = struct {
    /// The Amazon Resource Name (ARN) of the channel.
    channel_arn: []const u8,

    /// The time at which the channel was created.
    channel_creation_timestamp: i64,

    /// The unique identifier of the channel.
    channel_id: []const u8,

    /// The name of the channel.
    channel_name: []const u8,

    /// The current status of the channel. Valid values:
    ///
    /// * `CREATING` - The channel is being created.
    ///
    /// * `ACTIVE` - The channel is ready to deliver records.
    ///
    /// * `UPDATING` - The channel configuration is being updated.
    ///
    /// * `DELETING` - The channel is being deleted.
    ///
    /// * `FAILED` - See `ChannelStatusReason` for the failure cause.
    channel_status: ChannelStatus,

    /// A message describing the reason for a `FAILED` status.
    channel_status_reason: ?[]const u8 = null,

    /// The Amazon Web Services KMS key configuration that Amazon Kinesis Data
    /// Streams uses to encrypt data delivered to the channel's destination.
    encryption_configuration: ?ChannelEncryptionConfiguration = null,

    /// The Amazon CloudWatch Logs configuration for the channel.
    logging_configuration: ChannelLoggingConfiguration,

    /// The configuration for delivery to a general purpose Amazon S3 bucket.
    /// Present only when the channel destination is a general purpose Amazon S3
    /// bucket.
    s3_destination_configuration: ?S3DestinationDescription = null,

    /// The configuration for delivery to streaming tables on Apache Iceberg in
    /// Amazon S3 Tables. Present only when the channel destination is a streaming
    /// table.
    s3_tables_destination_configuration: ?S3TablesDestinationDescription = null,

    /// The Amazon Resource Name (ARN) of the IAM role that Amazon Kinesis Data
    /// Streams assumes to write records to the destination.
    service_execution_role_arn: []const u8,

    /// The source stream configuration for the channel.
    stream_configuration_list: []const ChannelStreamDescription,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .channel_creation_timestamp = "ChannelCreationTimestamp",
        .channel_id = "ChannelId",
        .channel_name = "ChannelName",
        .channel_status = "ChannelStatus",
        .channel_status_reason = "ChannelStatusReason",
        .encryption_configuration = "EncryptionConfiguration",
        .logging_configuration = "LoggingConfiguration",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .s3_tables_destination_configuration = "S3TablesDestinationConfiguration",
        .service_execution_role_arn = "ServiceExecutionRoleARN",
        .stream_configuration_list = "StreamConfigurationList",
    };
};
