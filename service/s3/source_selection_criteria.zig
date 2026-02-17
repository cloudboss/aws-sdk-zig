const ReplicaModifications = @import("replica_modifications.zig").ReplicaModifications;
const SseKmsEncryptedObjects = @import("sse_kms_encrypted_objects.zig").SseKmsEncryptedObjects;

/// A container that describes additional filters for identifying the source
/// objects that you want to
/// replicate. You can choose to enable or disable the replication of these
/// objects. Currently, Amazon S3
/// supports only the filter that you can specify for objects created with
/// server-side encryption using a
/// customer managed key stored in Amazon Web Services Key Management Service
/// (SSE-KMS).
pub const SourceSelectionCriteria = struct {
    /// A filter that you can specify for selections for modifications on replicas.
    /// Amazon S3 doesn't replicate
    /// replica modifications by default. In the latest version of replication
    /// configuration (when
    /// `Filter` is specified), you can specify this element and set the status to
    /// `Enabled` to replicate modifications on replicas.
    ///
    /// If you don't specify the `Filter` element, Amazon S3 assumes that the
    /// replication
    /// configuration is the earlier version, V1. In the earlier version, this
    /// element is not allowed
    replica_modifications: ?ReplicaModifications,

    /// A container for filter information for the selection of Amazon S3 objects
    /// encrypted with Amazon Web Services KMS. If
    /// you include `SourceSelectionCriteria` in the replication configuration, this
    /// element is
    /// required.
    sse_kms_encrypted_objects: ?SseKmsEncryptedObjects,
};
