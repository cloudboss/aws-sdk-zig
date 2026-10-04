const aws = @import("aws");

const S3TableGranularity = @import("s3_table_granularity.zig").S3TableGranularity;

/// Describes the state of Amazon S3 Tables system-table log publishing for a
/// namespace.
pub const S3TablePublishStatus = struct {
    /// `true` when the namespace is enrolled in every current and future system
    /// table rather than an explicit list of tables.
    enabled_all: ?bool = null,

    /// A map of system table name to the time that table last received data, as an
    /// ISO-8601 timestamp. A table that has not yet been ingested is absent from
    /// the map. Use it to judge data freshness.
    last_ingestion_times: ?[]const aws.map.StringMapEntry = null,

    /// The scope currently in effect. Values are `namespace` or `account`.
    s_3_table_granularity: ?S3TableGranularity = null,

    /// The identifier of the namespace in the S3 table bucket that holds the
    /// published tables.
    s_3_table_namespace: ?[]const u8 = null,

    /// The system tables currently being published.
    s_3_tables: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .enabled_all = "enabledAll",
        .last_ingestion_times = "lastIngestionTimes",
        .s_3_table_granularity = "s3TableGranularity",
        .s_3_table_namespace = "s3TableNamespace",
        .s_3_tables = "s3Tables",
    };
};
