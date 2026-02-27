const ReplicaModificationsStatus = @import("replica_modifications_status.zig").ReplicaModificationsStatus;

/// A filter that you can use to specify whether replica modification sync is
/// enabled.
/// S3 on Outposts replica modification sync can help you keep object metadata
/// synchronized
/// between replicas and source objects. By default, S3 on Outposts replicates
/// metadata from the
/// source objects to the replicas only. When replica modification sync is
/// enabled,
/// S3 on Outposts replicates metadata changes made to the replica copies back
/// to the source
/// object, making the replication bidirectional.
///
/// To replicate object metadata modifications on replicas, you can specify this
/// element and
/// set the `Status` of this element to `Enabled`.
///
/// You must enable replica modification sync on the source and destination
/// buckets to
/// replicate replica metadata changes between the source and the replicas.
pub const ReplicaModifications = struct {
    /// Specifies whether S3 on Outposts replicates modifications to object metadata
    /// on
    /// replicas.
    status: ReplicaModificationsStatus,
};
