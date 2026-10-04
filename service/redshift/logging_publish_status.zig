const S3TablePublishStatus = @import("s3_table_publish_status.zig").S3TablePublishStatus;

/// Describes the system table publishing status for a cluster.
pub const LoggingPublishStatus = struct {
    /// The status of system table publishing to S3 Tables.
    s3_tables: ?S3TablePublishStatus = null,
};
