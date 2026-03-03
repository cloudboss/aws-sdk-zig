const AccessControlTranslation = @import("access_control_translation.zig").AccessControlTranslation;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const Metrics = @import("metrics.zig").Metrics;
const ReplicationTime = @import("replication_time.zig").ReplicationTime;
const StorageClass = @import("storage_class.zig").StorageClass;

/// Specifies information about where to publish analysis or configuration
/// results for an Amazon S3 bucket
/// and S3 Replication Time Control (S3 RTC).
pub const Destination = struct {
    /// Specify this only in a cross-account scenario (where source and destination
    /// bucket owners are not
    /// the same), and you want to change replica ownership to the Amazon Web
    /// Services account that owns the destination
    /// bucket. If this is not specified in the replication configuration, the
    /// replicas are owned by same
    /// Amazon Web Services account that owns the source object.
    access_control_translation: ?AccessControlTranslation = null,

    /// Destination bucket owner account ID. In a cross-account scenario, if you
    /// direct Amazon S3 to change
    /// replica ownership to the Amazon Web Services account that owns the
    /// destination bucket by specifying the
    /// `AccessControlTranslation` property, this is the account ID of the
    /// destination bucket
    /// owner. For more information, see [Replication Additional Configuration:
    /// Changing
    /// the Replica
    /// Owner](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-change-owner.html) in the *Amazon S3 User Guide*.
    account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the bucket where you want Amazon S3 to
    /// store the results.
    bucket: []const u8,

    /// A container that provides information about encryption. If
    /// `SourceSelectionCriteria` is
    /// specified, you must specify this element.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// A container specifying replication metrics-related settings enabling
    /// replication metrics and
    /// events.
    metrics: ?Metrics = null,

    /// A container specifying S3 Replication Time Control (S3 RTC), including
    /// whether S3 RTC is enabled and the time when all
    /// objects and operations on objects must be replicated. Must be specified
    /// together with a
    /// `Metrics` block.
    replication_time: ?ReplicationTime = null,

    /// The storage class to use when replicating objects, such as S3 Standard or
    /// reduced redundancy. By
    /// default, Amazon S3 uses the storage class of the source object to create the
    /// object replica.
    ///
    /// For valid values, see the `StorageClass` element of the [PUT Bucket
    /// replication](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) action in the
    /// *Amazon S3 API Reference*.
    ///
    /// `FSX_OPENZFS` is not an accepted value when replicating objects.
    storage_class: ?StorageClass = null,
};
