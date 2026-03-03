const KeyNameConstraint = @import("key_name_constraint.zig").KeyNameConstraint;
const ObjectEncryptionFilter = @import("object_encryption_filter.zig").ObjectEncryptionFilter;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// The filter used to describe a set of objects for the job's manifest.
pub const JobManifestGeneratorFilter = struct {
    /// If provided, the generated manifest includes only source bucket objects that
    /// were
    /// created after this time.
    created_after: ?i64 = null,

    /// If provided, the generated manifest includes only source bucket objects that
    /// were
    /// created before this time.
    created_before: ?i64 = null,

    /// Include objects in the generated manifest only if they are eligible for
    /// replication
    /// according to the Replication configuration on the source bucket.
    eligible_for_replication: ?bool = null,

    /// If provided, the generated manifest includes only source bucket objects
    /// whose object
    /// keys match the string constraints specified for `MatchAnyPrefix`,
    /// `MatchAnySuffix`, and `MatchAnySubstring`.
    key_name_constraint: ?KeyNameConstraint = null,

    /// If provided, the generated object list includes only source bucket objects
    /// with the indicated server-side encryption type (SSE-S3, SSE-KMS, DSSE-KMS,
    /// SSE-C, or NOT-SSE).
    match_any_object_encryption: ?[]const ObjectEncryptionFilter = null,

    /// If provided, the generated manifest includes only source bucket objects that
    /// are stored
    /// with the specified storage class.
    match_any_storage_class: ?[]const S3StorageClass = null,

    /// If provided, the generated manifest includes only source bucket objects that
    /// have one of
    /// the specified Replication statuses.
    object_replication_statuses: ?[]const ReplicationStatus = null,

    /// If provided, the generated manifest includes only source bucket objects
    /// whose file size
    /// is greater than the specified number of bytes.
    object_size_greater_than_bytes: ?i64 = null,

    /// If provided, the generated manifest includes only source bucket objects
    /// whose file size
    /// is less than the specified number of bytes.
    object_size_less_than_bytes: ?i64 = null,
};
