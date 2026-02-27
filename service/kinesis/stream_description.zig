const EncryptionType = @import("encryption_type.zig").EncryptionType;
const EnhancedMetrics = @import("enhanced_metrics.zig").EnhancedMetrics;
const Shard = @import("shard.zig").Shard;
const StreamModeDetails = @import("stream_mode_details.zig").StreamModeDetails;
const StreamStatus = @import("stream_status.zig").StreamStatus;

/// Represents the output for DescribeStream.
pub const StreamDescription = struct {
    /// The server-side encryption type used on the stream. This parameter can be
    /// one of the
    /// following values:
    ///
    /// * `NONE`: Do not encrypt the records in the stream.
    ///
    /// * `KMS`: Use server-side encryption on the records in the stream
    /// using a customer-managed Amazon Web Services KMS key.
    encryption_type: ?EncryptionType,

    /// Represents the current enhanced monitoring settings of the stream.
    enhanced_monitoring: []const EnhancedMetrics,

    /// If set to `true`, more shards in the stream are available to
    /// describe.
    has_more_shards: bool,

    /// The GUID for the customer-managed Amazon Web Services KMS key to use for
    /// encryption.
    /// This value can be a globally unique identifier, a fully specified ARN to
    /// either an alias
    /// or a key, or an alias name prefixed by "alias/".You can also use a master
    /// key owned by
    /// Kinesis Data Streams by specifying the alias `aws/kinesis`.
    ///
    /// * Key ARN example:
    /// `arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012`
    ///
    /// * Alias ARN example:
    /// `arn:aws:kms:us-east-1:123456789012:alias/MyAliasName`
    ///
    /// * Globally unique key ID example:
    /// `12345678-1234-1234-1234-123456789012`
    ///
    /// * Alias name example: `alias/MyAliasName`
    ///
    /// * Master key owned by Kinesis Data Streams:
    /// `alias/aws/kinesis`
    key_id: ?[]const u8,

    /// The current retention period, in hours. Minimum value of 24. Maximum value
    /// of
    /// 168.
    retention_period_hours: i32,

    /// The shards that comprise the stream.
    shards: []const Shard,

    /// The Amazon Resource Name (ARN) for the stream being described.
    stream_arn: []const u8,

    /// The approximate time that the stream was created.
    stream_creation_timestamp: i64,

    /// Specifies the capacity mode to which you want to set your data stream.
    /// Currently, in
    /// Kinesis Data Streams, you can choose between an **on-demand** capacity mode
    /// and a **provisioned** capacity mode for your data streams.
    stream_mode_details: ?StreamModeDetails,

    /// The name of the stream being described.
    stream_name: []const u8,

    /// The current status of the stream being described. The stream status is one
    /// of the
    /// following states:
    ///
    /// * `CREATING` - The stream is being created. Kinesis Data Streams
    /// immediately returns and sets `StreamStatus` to
    /// `CREATING`.
    ///
    /// * `DELETING` - The stream is being deleted. The specified stream is in
    /// the `DELETING` state until Kinesis Data Streams completes the
    /// deletion.
    ///
    /// * `ACTIVE` - The stream exists and is ready for read and write
    /// operations or deletion. You should perform read and write operations only on
    /// an
    /// `ACTIVE` stream.
    ///
    /// * `UPDATING` - Shards in the stream are being merged or split. Read and
    /// write operations continue to work while the stream is in the
    /// `UPDATING` state.
    stream_status: StreamStatus,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .enhanced_monitoring = "EnhancedMonitoring",
        .has_more_shards = "HasMoreShards",
        .key_id = "KeyId",
        .retention_period_hours = "RetentionPeriodHours",
        .shards = "Shards",
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
        .stream_mode_details = "StreamModeDetails",
        .stream_name = "StreamName",
        .stream_status = "StreamStatus",
    };
};
