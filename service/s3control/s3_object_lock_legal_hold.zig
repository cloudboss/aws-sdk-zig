const S3ObjectLockLegalHoldStatus = @import("s3_object_lock_legal_hold_status.zig").S3ObjectLockLegalHoldStatus;

/// Whether S3 Object Lock legal hold will be applied to objects in an S3 Batch
/// Operations
/// job.
pub const S3ObjectLockLegalHold = struct {
    /// The Object Lock legal hold status to be applied to all objects in the Batch
    /// Operations
    /// job.
    status: S3ObjectLockLegalHoldStatus,
};
