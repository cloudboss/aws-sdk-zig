const PartitionSpec = @import("partition_spec.zig").PartitionSpec;

/// Describes the configuration of a destination in Apache Iceberg Tables.
pub const DestinationTableConfiguration = struct {
    /// The name of the Apache Iceberg database.
    destination_database_name: []const u8,

    /// Specifies the name of the Apache Iceberg Table.
    destination_table_name: []const u8,

    /// The partition spec configuration for a table that is used by automatic table
    /// creation.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    partition_spec: ?PartitionSpec,

    /// The table specific S3 error output prefix. All the errors that occurred
    /// while delivering to this table will be prefixed with this value in S3
    /// destination.
    s3_error_output_prefix: ?[]const u8,

    /// A list of unique keys for a given Apache Iceberg table. Firehose will use
    /// these for running Create, Update, or Delete operations on the given Iceberg
    /// table.
    unique_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .destination_database_name = "DestinationDatabaseName",
        .destination_table_name = "DestinationTableName",
        .partition_spec = "PartitionSpec",
        .s3_error_output_prefix = "S3ErrorOutputPrefix",
        .unique_keys = "UniqueKeys",
    };
};
