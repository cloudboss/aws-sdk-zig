const EncryptionType = @import("encryption_type.zig").EncryptionType;
const EnhancedMetrics = @import("enhanced_metrics.zig").EnhancedMetrics;
const StreamModeDetails = @import("stream_mode_details.zig").StreamModeDetails;
const StreamStatus = @import("stream_status.zig").StreamStatus;
const WarmThroughputObject = @import("warm_throughput_object.zig").WarmThroughputObject;

/// Represents the output for DescribeStreamSummary
pub const StreamDescriptionSummary = struct {
    /// The number of enhanced fan-out consumers registered with the stream.
    consumer_count: ?i32 = null,

    /// The encryption type used. This value is one of the following:
    ///
    /// * `KMS`
    ///
    /// * `NONE`
    encryption_type: ?EncryptionType = null,

    /// Represents the current enhanced monitoring settings of the stream.
    enhanced_monitoring: []const EnhancedMetrics,

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
    /// * Alias ARN example: `
    /// arn:aws:kms:us-east-1:123456789012:alias/MyAliasName`
    ///
    /// * Globally unique key ID example:
    /// `12345678-1234-1234-1234-123456789012`
    ///
    /// * Alias name example: `alias/MyAliasName`
    ///
    /// * Master key owned by Kinesis Data Streams:
    /// `alias/aws/kinesis`
    key_id: ?[]const u8 = null,

    /// The maximum record size of a single record in kibibyte (KiB) that you can
    /// write to, and read from a stream.
    max_record_size_in_ki_b: ?i32 = null,

    /// The number of open shards in the stream.
    open_shard_count: i32,

    /// The current retention period, in hours.
    retention_period_hours: i32,

    /// The Amazon Resource Name (ARN) for the stream being described.
    stream_arn: []const u8,

    /// The approximate time that the stream was created.
    stream_creation_timestamp: i64,

    /// Not Implemented. Reserved for future use.
    stream_id: ?[]const u8 = null,

    /// Specifies the capacity mode to which you want to set your data stream.
    /// Currently, in
    /// Kinesis Data Streams, you can choose between an **on-demand** ycapacity mode
    /// and a **provisioned** capacity mode for your data streams.
    stream_mode_details: ?StreamModeDetails = null,

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

    /// The warm throughput in MB/s for the stream. This represents the throughput
    /// capacity that will be immediately available for write operations.
    warm_throughput: ?WarmThroughputObject = null,

    pub const json_field_names = .{
        .consumer_count = "ConsumerCount",
        .encryption_type = "EncryptionType",
        .enhanced_monitoring = "EnhancedMonitoring",
        .key_id = "KeyId",
        .max_record_size_in_ki_b = "MaxRecordSizeInKiB",
        .open_shard_count = "OpenShardCount",
        .retention_period_hours = "RetentionPeriodHours",
        .stream_arn = "StreamARN",
        .stream_creation_timestamp = "StreamCreationTimestamp",
        .stream_id = "StreamId",
        .stream_mode_details = "StreamModeDetails",
        .stream_name = "StreamName",
        .stream_status = "StreamStatus",
        .warm_throughput = "WarmThroughput",
    };
};
