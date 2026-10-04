const S3ObjectLockRetentionEventHold = @import("s3_object_lock_retention_event_hold.zig").S3ObjectLockRetentionEventHold;
const S3ObjectLockRetentionEventHoldDuration = @import("s3_object_lock_retention_event_hold_duration.zig").S3ObjectLockRetentionEventHoldDuration;
const S3ObjectLockRetentionMode = @import("s3_object_lock_retention_mode.zig").S3ObjectLockRetentionMode;

/// Contains the S3 Object Lock retention mode to be applied to all objects in
/// the
/// S3 Batch Operations job. If you don't provide `Mode` and `RetainUntilDate`
/// data types in your operation, you will remove the retention from your
/// objects. For more
/// information, see [Using S3 Object Lock retention
/// with S3 Batch
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/dev/batch-ops-retention-date.html) in the *Amazon S3 User Guide*.
pub const S3Retention = struct {
    /// The event hold status to be applied to all objects in the Batch Operations
    /// job. Set to
    /// `ON` to enable an event hold or `OFF` to disable it.
    event_hold: ?S3ObjectLockRetentionEventHold = null,

    /// The event hold duration to be applied to all objects in the Batch Operations
    /// job. The duration
    /// specifies how long the object remains protected after the event hold is
    /// released.
    event_hold_duration: ?S3ObjectLockRetentionEventHoldDuration = null,

    /// The Object Lock retention mode to be applied to all objects in the Batch
    /// Operations
    /// job.
    mode: ?S3ObjectLockRetentionMode = null,

    /// The date when the applied Object Lock retention will expire on all objects
    /// set by the
    /// Batch Operations job.
    retain_until_date: ?i64 = null,
};
