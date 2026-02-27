const S3Retention = @import("s3_retention.zig").S3Retention;

/// Contains the configuration parameters for the Object Lock retention action
/// for an
/// S3 Batch Operations job. Batch Operations passes every object to the
/// underlying
/// `PutObjectRetention`
/// API
/// operation. For more information, see [Using S3 Object Lock retention
/// with S3 Batch
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-retention-date.html) in the *Amazon S3 User Guide*.
///
/// This functionality is not supported by directory buckets.
pub const S3SetObjectRetentionOperation = struct {
    /// Indicates if the action should be applied to objects in the Batch Operations
    /// job even if they
    /// have Object Lock ` GOVERNANCE` type in place.
    bypass_governance_retention: ?bool,

    /// Contains the Object Lock retention mode to be applied to all objects in the
    /// Batch Operations
    /// job. For more information, see [Using S3 Object Lock retention
    /// with S3 Batch
    /// Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-retention-date.html) in the *Amazon S3 User Guide*.
    retention: S3Retention,
};
