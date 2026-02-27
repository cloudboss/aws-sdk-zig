const aws = @import("aws");

const Column = @import("column.zig").Column;
const StorageDescriptor = @import("storage_descriptor.zig").StorageDescriptor;
const TableIdentifier = @import("table_identifier.zig").TableIdentifier;
const ViewDefinitionInput = @import("view_definition_input.zig").ViewDefinitionInput;

/// A structure used to define a table.
pub const TableInput = struct {
    /// A description of the table.
    description: ?[]const u8,

    /// The last time that the table was accessed.
    last_access_time: ?i64,

    /// The last time that column statistics were computed for this table.
    last_analyzed_time: ?i64,

    /// The table name. For Hive compatibility, this is folded to
    /// lowercase when it is stored.
    name: []const u8,

    /// The table owner. Included for Apache Hive compatibility. Not used in the
    /// normal course of Glue operations.
    owner: ?[]const u8,

    /// These key-value pairs define properties associated with the table.
    parameters: ?[]const aws.map.StringMapEntry,

    /// A list of columns by which the table is partitioned. Only primitive
    /// types are supported as partition keys.
    ///
    /// When you create a table used by Amazon Athena, and you do not specify any
    /// `partitionKeys`, you must at least set the value of `partitionKeys` to
    /// an empty list. For example:
    ///
    /// `"PartitionKeys": []`
    partition_keys: ?[]const Column,

    /// The retention time for this table.
    retention: i32 = 0,

    /// A storage descriptor containing information about the physical storage
    /// of this table.
    storage_descriptor: ?StorageDescriptor,

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
    table_type: ?[]const u8,

    /// A `TableIdentifier` structure that describes a target table for resource
    /// linking.
    target_table: ?TableIdentifier,

    /// A structure that contains all the information that defines the view,
    /// including the dialect or dialects for the view, and the query.
    view_definition: ?ViewDefinitionInput,

    /// Included for Apache Hive compatibility. Not used in the normal course of
    /// Glue operations.
    view_expanded_text: ?[]const u8,

    /// Included for Apache Hive compatibility. Not used in the normal course of
    /// Glue operations.
    /// If the table is a `VIRTUAL_VIEW`, certain Athena configuration encoded in
    /// base64.
    view_original_text: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .last_access_time = "LastAccessTime",
        .last_analyzed_time = "LastAnalyzedTime",
        .name = "Name",
        .owner = "Owner",
        .parameters = "Parameters",
        .partition_keys = "PartitionKeys",
        .retention = "Retention",
        .storage_descriptor = "StorageDescriptor",
        .table_type = "TableType",
        .target_table = "TargetTable",
        .view_definition = "ViewDefinition",
        .view_expanded_text = "ViewExpandedText",
        .view_original_text = "ViewOriginalText",
    };
};
