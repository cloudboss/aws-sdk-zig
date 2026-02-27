const ExistingObjectReplicationStatus = @import("existing_object_replication_status.zig").ExistingObjectReplicationStatus;

/// An optional configuration to replicate existing source bucket objects.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const ExistingObjectReplication = struct {
    /// Specifies whether Amazon S3 replicates existing source bucket objects.
    status: ExistingObjectReplicationStatus,
};
