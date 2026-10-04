const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// Describes a single annotation attached to an object, including its name,
/// last modified time,
/// size, ETag, checksum algorithm, and replication status. Returned in the
/// response from
/// `ListObjectAnnotations`.
pub const AnnotationEntry = struct {
    /// The name of the annotation.
    annotation_name: []const u8,

    /// The checksum algorithm used for the annotation.
    checksum_algorithm: ?[]const ChecksumAlgorithm = null,

    /// The entity tag of the annotation.
    e_tag: ?[]const u8 = null,

    /// The date and time the annotation was last modified.
    last_modified: i64,

    /// The replication status of the annotation.
    replication_status: ?ReplicationStatus = null,

    /// The size of the annotation payload, in bytes.
    size: i64,
};
