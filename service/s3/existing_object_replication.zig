const ExistingObjectReplicationStatus = @import("existing_object_replication_status.zig").ExistingObjectReplicationStatus;

/// Optional configuration to replicate existing source bucket objects.
///
/// This parameter is no longer supported. To replicate existing objects, see
/// [Replicating
/// existing objects with S3 Batch
/// Replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-batch-replication-batch.html) in the
/// *Amazon S3 User Guide*.
pub const ExistingObjectReplication = struct {
    /// Specifies whether Amazon S3 replicates existing source bucket objects.
    status: ExistingObjectReplicationStatus,
};
