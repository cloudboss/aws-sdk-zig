const aws = @import("aws");

const FederatedTable = @import("federated_table.zig").FederatedTable;
const Column = @import("column.zig").Column;
const TableStatus = @import("table_status.zig").TableStatus;
const StorageDescriptor = @import("storage_descriptor.zig").StorageDescriptor;
const TableIdentifier = @import("table_identifier.zig").TableIdentifier;
const ViewDefinition = @import("view_definition.zig").ViewDefinition;

/// Represents a collection of related data organized in columns and rows.
pub const Table = struct {
    /// The ID of the Data Catalog in which the table resides.
    catalog_id: ?[]const u8 = null,

    /// The person or entity who created the table.
    created_by: ?[]const u8 = null,

    /// The time when the table definition was created in the Data Catalog.
    create_time: ?i64 = null,

    /// The name of the database where the table metadata resides.
    /// For Hive compatibility, this must be all lowercase.
    database_name: ?[]const u8 = null,

    /// A description of the table.
    description: ?[]const u8 = null,

    /// A `FederatedTable` structure that references an entity outside the Glue Data
    /// Catalog.
    federated_table: ?FederatedTable = null,

    /// Indicates a table is a `MaterializedView`.
    is_materialized_view: ?bool = null,

    /// Specifies whether the view supports the SQL dialects of one or more
    /// different query engines and can therefore be read by those engines.
    is_multi_dialect_view: ?bool = null,

    /// Indicates whether the table has been registered with Lake Formation.
    is_registered_with_lake_formation: bool = false,

    /// The last time that the table was accessed. This is usually taken from HDFS,
    /// and might not
    /// be reliable.
    last_access_time: ?i64 = null,

    /// The last time that column statistics were computed for this table.
    last_analyzed_time: ?i64 = null,

    /// The table name. For Hive compatibility, this must be entirely
    /// lowercase.
    name: []const u8,

    /// The owner of the table.
    owner: ?[]const u8 = null,

    /// These key-value pairs define properties associated with the table.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// A list of columns by which the table is partitioned. Only primitive
    /// types are supported as partition keys.
    ///
    /// When you create a table used by Amazon Athena, and you do not specify any
    /// `partitionKeys`, you must at least set the value of `partitionKeys` to
    /// an empty list. For example:
    ///
    /// `"PartitionKeys": []`
    partition_keys: ?[]const Column = null,

    /// The retention time for this table.
    retention: i32 = 0,

    /// Indicates the the state of an asynchronous change to a table.
    status: ?*TableStatus = null,

    /// A storage descriptor containing information about the physical storage
    /// of this table.
    storage_descriptor: ?StorageDescriptor = null,

    /// The type of this table.
    /// Glue will create tables with the `EXTERNAL_TABLE` type.
    /// Other services, such as Athena, may create tables with additional table
    /// types.
    ///
    /// Glue related table types:
    ///
    /// **EXTERNAL_TABLE**
    ///
    /// Hive compatible attribute - indicates a non-Hive managed table.
    ///
    /// **GOVERNED**
    ///
    /// Used by Lake Formation.
    /// The Glue Data Catalog understands `GOVERNED`.
    table_type: ?[]const u8 = null,

    /// A `TableIdentifier` structure that describes a target table for resource
    /// linking.
    target_table: ?TableIdentifier = null,

    /// The last time that the table was updated.
    update_time: ?i64 = null,

    /// The ID of the table version.
    version_id: ?[]const u8 = null,

    /// A structure that contains all the information that defines the view,
    /// including the dialect or dialects for the view, and the query.
    view_definition: ?ViewDefinition = null,

    /// Included for Apache Hive compatibility. Not used in the normal course of
    /// Glue operations.
    view_expanded_text: ?[]const u8 = null,

    /// Included for Apache Hive compatibility. Not used in the normal course of
    /// Glue operations.
    /// If the table is a `VIRTUAL_VIEW`, certain Athena configuration encoded in
    /// base64.
    view_original_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .created_by = "CreatedBy",
        .create_time = "CreateTime",
        .database_name = "DatabaseName",
        .description = "Description",
        .federated_table = "FederatedTable",
        .is_materialized_view = "IsMaterializedView",
        .is_multi_dialect_view = "IsMultiDialectView",
        .is_registered_with_lake_formation = "IsRegisteredWithLakeFormation",
        .last_access_time = "LastAccessTime",
        .last_analyzed_time = "LastAnalyzedTime",
        .name = "Name",
        .owner = "Owner",
        .parameters = "Parameters",
        .partition_keys = "PartitionKeys",
        .retention = "Retention",
        .status = "Status",
        .storage_descriptor = "StorageDescriptor",
        .table_type = "TableType",
        .target_table = "TargetTable",
        .update_time = "UpdateTime",
        .version_id = "VersionId",
        .view_definition = "ViewDefinition",
        .view_expanded_text = "ViewExpandedText",
        .view_original_text = "ViewOriginalText",
    };
};
