const ColumnDefinition = @import("column_definition.zig").ColumnDefinition;
const ClusteringKey = @import("clustering_key.zig").ClusteringKey;
const PartitionKey = @import("partition_key.zig").PartitionKey;
const StaticColumn = @import("static_column.zig").StaticColumn;

/// Describes the schema of the table.
pub const SchemaDefinition = struct {
    /// The regular columns of the table.
    all_columns: []const ColumnDefinition,

    /// The columns that are part of the clustering key of the table.
    clustering_keys: ?[]const ClusteringKey = null,

    /// The columns that are part of the partition key of the table .
    partition_keys: []const PartitionKey,

    /// The columns that have been defined as `STATIC`. Static columns store values
    /// that are shared by all rows in the same partition.
    static_columns: ?[]const StaticColumn = null,

    pub const json_field_names = .{
        .all_columns = "allColumns",
        .clustering_keys = "clusteringKeys",
        .partition_keys = "partitionKeys",
        .static_columns = "staticColumns",
    };
};
