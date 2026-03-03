const CatalogType = @import("catalog_type.zig").CatalogType;
const RegistrationOutput = @import("registration_output.zig").RegistrationOutput;

/// Describes the metadata catalog, metadata table, and data partitions that
/// Amazon AppFlow used for the associated flow run.
pub const MetadataCatalogDetail = struct {
    /// The type of metadata catalog that Amazon AppFlow used for the associated
    /// flow run.
    /// This parameter returns the following value:
    ///
    /// **GLUE**
    ///
    /// The metadata catalog is provided by the Glue Data Catalog. Glue
    /// includes the Glue Data Catalog as a component.
    catalog_type: ?CatalogType = null,

    /// Describes the status of the attempt from Amazon AppFlow to register the data
    /// partitions with the metadata catalog. The data partitions organize the flow
    /// output into a
    /// hierarchical path, such as a folder path in an S3 bucket. Amazon AppFlow
    /// creates the
    /// partitions (if they don't already exist) based on your flow configuration.
    partition_registration_output: ?RegistrationOutput = null,

    /// The name of the table that stores the metadata for the associated flow run.
    /// The table
    /// stores metadata that represents the data that the flow transferred. Amazon
    /// AppFlow stores
    /// the table in the metadata catalog.
    table_name: ?[]const u8 = null,

    /// Describes the status of the attempt from Amazon AppFlow to register the
    /// metadata
    /// table with the metadata catalog. Amazon AppFlow creates or updates this
    /// table for the
    /// associated flow run.
    table_registration_output: ?RegistrationOutput = null,

    pub const json_field_names = .{
        .catalog_type = "catalogType",
        .partition_registration_output = "partitionRegistrationOutput",
        .table_name = "tableName",
        .table_registration_output = "tableRegistrationOutput",
    };
};
