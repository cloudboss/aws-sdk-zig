const ReplicaModifications = @import("replica_modifications.zig").ReplicaModifications;
const SseKmsEncryptedObjects = @import("sse_kms_encrypted_objects.zig").SseKmsEncryptedObjects;

/// A container that describes additional filters for identifying the source
/// objects that
/// you want to replicate. You can choose to enable or disable the replication
/// of these
/// objects.
pub const SourceSelectionCriteria = struct {
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
    replica_modifications: ?ReplicaModifications = null,

    /// A filter that you can use to select Amazon S3 objects that are encrypted
    /// with server-side
    /// encryption by using Key Management Service (KMS) keys. If you include
    /// `SourceSelectionCriteria` in the replication configuration, this element is
    /// required.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    sse_kms_encrypted_objects: ?SseKmsEncryptedObjects = null,
};
