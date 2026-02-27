const DeleteMarkerReplicationStatus = @import("delete_marker_replication_status.zig").DeleteMarkerReplicationStatus;

/// Specifies whether S3 on Outposts replicates delete markers. If you specify a
/// `Filter` element in your replication configuration, you must also include a
/// `DeleteMarkerReplication` element. If your `Filter` includes a
/// `Tag` element, the `DeleteMarkerReplication` element's
/// `Status` child element must be set to `Disabled`, because
/// S3 on Outposts does not support replicating delete markers for tag-based
/// rules.
///
/// For more information about delete marker replication, see [How delete
/// operations affect
/// replication](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3OutpostsReplication.html#outposts-replication-what-is-replicated) in the
/// *Amazon S3 User Guide*.
pub const DeleteMarkerReplication = struct {
    /// Indicates whether to replicate delete markers.
    status: DeleteMarkerReplicationStatus,
};
