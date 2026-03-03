const AwsKinesisStreamStreamEncryptionDetails = @import("aws_kinesis_stream_stream_encryption_details.zig").AwsKinesisStreamStreamEncryptionDetails;

/// Provides information about an Amazon Kinesis data stream.
pub const AwsKinesisStreamDetails = struct {
    /// The Amazon Resource Name (ARN) of the Kinesis data stream.
    arn: ?[]const u8 = null,

    /// The name of the Kinesis stream. If you don't specify a name, CloudFront
    /// generates a unique
    /// physical ID and uses that ID for the stream name.
    name: ?[]const u8 = null,

    /// The number of hours for the data records that are stored in shards to remain
    /// accessible.
    retention_period_hours: ?i32 = null,

    /// The number of shards that the stream uses.
    shard_count: ?i32 = null,

    /// When specified, enables or updates server-side encryption using an KMS key
    /// for a specified stream.
    /// Removing this property from your stack template and updating your stack
    /// disables encryption.
    stream_encryption: ?AwsKinesisStreamStreamEncryptionDetails = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .retention_period_hours = "RetentionPeriodHours",
        .shard_count = "ShardCount",
        .stream_encryption = "StreamEncryption",
    };
};
