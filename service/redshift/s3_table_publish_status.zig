const aws = @import("aws");

/// Describes the status of system table publishing to S3 Tables for a cluster.
pub const S3TablePublishStatus = struct {
    /// `true` if the cluster is enrolled in all current and future system tables
    /// rather than an explicit subset.
    enabled_all: ?bool = null,

    /// A map whose keys are the names of the published system tables and whose
    /// values are the time each table last received data. Use this to judge data
    /// freshness.
    last_ingestion_times: ?[]const aws.map.StringMapEntry = null,

    /// The scope of system table publishing in effect. Possible values are
    /// `cluster` and `account`.
    s3_table_granularity: ?[]const u8 = null,

    /// The namespace in the S3 table bucket that holds the published tables.
    s3_table_namespace: ?[]const u8 = null,

    /// The system tables currently being published.
    s3_tables: ?[]const []const u8 = null,
};
