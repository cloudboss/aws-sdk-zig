const aws = @import("aws");

/// The database and table in the Glue Data Catalog that is used for input or
/// output data.
pub const GlueTable = struct {
    /// Additional options for the table. Currently there are two keys supported:
    ///
    /// * `pushDownPredicate`: to filter on partitions without having to list and
    ///   read all the files in your dataset.
    ///
    /// * `catalogPartitionPredicate`: to use server-side partition pruning using
    ///   partition indexes in the Glue Data Catalog.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the Glue Data Catalog.
    catalog_id: ?[]const u8 = null,

    /// The name of the connection to the Glue Data Catalog.
    connection_name: ?[]const u8 = null,

    /// A database name in the Glue Data Catalog.
    database_name: []const u8,

    /// A table name in the Glue Data Catalog.
    table_name: []const u8,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .catalog_id = "CatalogId",
        .connection_name = "ConnectionName",
        .database_name = "DatabaseName",
        .table_name = "TableName",
    };
};
