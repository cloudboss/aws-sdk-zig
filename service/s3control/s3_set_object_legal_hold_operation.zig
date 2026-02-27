const S3ObjectLockLegalHold = @import("s3_object_lock_legal_hold.zig").S3ObjectLockLegalHold;

/// Contains the configuration for an S3 Object Lock legal hold operation that
/// an
/// S3 Batch Operations job passes
/// to
/// every object to the underlying
/// `PutObjectLegalHold`
/// API
/// operation. For more information, see [Using S3 Object Lock legal hold
/// with S3 Batch
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-legal-hold.html) in the *Amazon S3 User Guide*.
///
/// This functionality is not supported by directory buckets.
pub const S3SetObjectLegalHoldOperation = struct {
    /// Contains the Object Lock legal hold status to be applied to all objects in
    /// the
    /// Batch Operations job.
    legal_hold: S3ObjectLockLegalHold,
};
