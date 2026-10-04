const PartitionSpec = @import("partition_spec.zig").PartitionSpec;

/// Configuration of an Apache Iceberg destination table.
pub const DestinationTable = struct {
    /// The name of the destination namespace (database) in the AWS Glue Data
    /// Catalog.
    destination_database_name: ?[]const u8 = null,

    /// The name of the destination Apache Iceberg table.
    destination_table_name: ?[]const u8 = null,

    /// The partition specification for the destination table.
    partition_spec: ?PartitionSpec = null,

    pub const json_field_names = .{
        .destination_database_name = "DestinationDatabaseName",
        .destination_table_name = "DestinationTableName",
        .partition_spec = "PartitionSpec",
    };
};
