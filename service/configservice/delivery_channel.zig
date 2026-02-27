const ConfigSnapshotDeliveryProperties = @import("config_snapshot_delivery_properties.zig").ConfigSnapshotDeliveryProperties;

/// The channel through which Config delivers notifications and
/// updated configuration states.
pub const DeliveryChannel = struct {
    /// The options for how often Config delivers configuration
    /// snapshots to the Amazon S3 bucket.
    config_snapshot_delivery_properties: ?ConfigSnapshotDeliveryProperties,

    /// The name of the delivery channel. By default, Config
    /// assigns the name "default" when creating the delivery channel. To
    /// change the delivery channel name, you must use the
    /// DeleteDeliveryChannel action to delete your current delivery
    /// channel, and then you must use the PutDeliveryChannel command to
    /// create a delivery channel that has the desired name.
    name: ?[]const u8,

    /// The name of the Amazon S3 bucket to which Config delivers
    /// configuration snapshots and configuration history files.
    ///
    /// If you specify a bucket that belongs to another Amazon Web Services account,
    /// that bucket must have policies that grant access permissions to Config. For
    /// more information, see [Permissions for the Amazon S3
    /// Bucket](https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html) in the *Config
    /// Developer Guide*.
    s_3_bucket_name: ?[]const u8,

    /// The prefix for the specified Amazon S3 bucket.
    s_3_key_prefix: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Key Management Service (KMS ) KMS key
    /// (KMS key) used to encrypt objects delivered by Config.
    /// Must belong to the same Region as the destination S3 bucket.
    s_3_kms_key_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic to which
    /// Config sends notifications about configuration
    /// changes.
    ///
    /// If you choose a topic from another account, the topic must have
    /// policies that grant access permissions to Config. For more
    /// information, see [Permissions for the Amazon SNS
    /// Topic](https://docs.aws.amazon.com/config/latest/developerguide/sns-topic-policy.html) in the *Config
    /// Developer Guide*.
    sns_topic_arn: ?[]const u8,

    pub const json_field_names = .{
        .config_snapshot_delivery_properties = "configSnapshotDeliveryProperties",
        .name = "name",
        .s_3_bucket_name = "s3BucketName",
        .s_3_key_prefix = "s3KeyPrefix",
        .s_3_kms_key_arn = "s3KmsKeyArn",
        .sns_topic_arn = "snsTopicARN",
    };
};
