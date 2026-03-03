const aws = @import("aws");

/// A structure that contains the output properties of Iceberg table
/// optimization configuration for your catalog resource in the Glue
/// Data Catalog.
pub const IcebergOptimizationPropertiesOutput = struct {
    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// table compaction operations, which optimize the layout of data files to
    /// improve query performance.
    compaction: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the Iceberg optimization properties were last updated.
    last_updated_time: ?i64 = null,

    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// orphan file deletion operations, which identify and remove files that are no
    /// longer referenced by the table metadata.
    orphan_file_deletion: ?[]const aws.map.StringMapEntry = null,

    /// A map of key-value pairs that specify configuration parameters for Iceberg
    /// table retention operations, which manage the lifecycle of table snapshots to
    /// control storage costs.
    retention: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM role that is used to perform
    /// Iceberg table optimization operations.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .compaction = "Compaction",
        .last_updated_time = "LastUpdatedTime",
        .orphan_file_deletion = "OrphanFileDeletion",
        .retention = "Retention",
        .role_arn = "RoleArn",
    };
};
