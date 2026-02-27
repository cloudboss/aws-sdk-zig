const aws = @import("aws");

/// A structure that specifies Iceberg table optimization properties for the
/// catalog, including configurations for compaction, retention, and orphan file
/// deletion operations.
pub const IcebergOptimizationProperties = struct {
    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// table compaction operations, which optimize the layout of data files to
    /// improve query performance.
    compaction: ?[]const aws.map.StringMapEntry,

    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// orphan file deletion operations, which identify and remove files that are no
    /// longer referenced by the table metadata.
    orphan_file_deletion: ?[]const aws.map.StringMapEntry,

    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// table retention operations, which manage the lifecycle of table snapshots to
    /// control storage costs.
    retention: ?[]const aws.map.StringMapEntry,

    /// The Amazon Resource Name (ARN) of the IAM role that will be assumed to
    /// perform Iceberg table optimization operations.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .compaction = "Compaction",
        .orphan_file_deletion = "OrphanFileDeletion",
        .retention = "Retention",
        .role_arn = "RoleArn",
    };
};
