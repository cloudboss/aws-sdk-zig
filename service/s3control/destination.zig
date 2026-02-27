const AccessControlTranslation = @import("access_control_translation.zig").AccessControlTranslation;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const Metrics = @import("metrics.zig").Metrics;
const ReplicationTime = @import("replication_time.zig").ReplicationTime;
const ReplicationStorageClass = @import("replication_storage_class.zig").ReplicationStorageClass;

/// Specifies information about the replication destination bucket and its
/// settings for an
/// S3 on Outposts replication configuration.
pub const Destination = struct {
    /// Specify this property only in a cross-account scenario (where the source and
    /// destination
    /// bucket owners are not the same), and you want to change replica ownership to
    /// the
    /// Amazon Web Services account that owns the destination bucket. If this
    /// property is not specified in the
    /// replication configuration, the replicas are owned by same Amazon Web
    /// Services account that owns the
    /// source object.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    access_control_translation: ?AccessControlTranslation,

    /// The destination bucket owner's account ID.
    account: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the access point for the destination
    /// bucket where you want
    /// S3 on Outposts to store the replication results.
    bucket: []const u8,

    /// A container that provides information about encryption. If
    /// `SourceSelectionCriteria` is specified, you must specify this element.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    encryption_configuration: ?EncryptionConfiguration,

    /// A container that specifies replication metrics-related settings.
    metrics: ?Metrics,

    /// A container that specifies S3 Replication Time Control (S3 RTC) settings,
    /// including whether S3 RTC is enabled
    /// and the time when all objects and operations on objects must be replicated.
    /// Must be
    /// specified together with a `Metrics` block.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    replication_time: ?ReplicationTime,

    /// The storage class to use when replicating objects. All objects stored on S3
    /// on Outposts
    /// are stored in the `OUTPOSTS` storage class. S3 on Outposts uses the
    /// `OUTPOSTS` storage class to create the object replicas.
    ///
    /// Values other than `OUTPOSTS` aren't supported by Amazon S3 on Outposts.
    storage_class: ?ReplicationStorageClass,
};
