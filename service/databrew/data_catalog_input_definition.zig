const S3Location = @import("s3_location.zig").S3Location;

/// Represents how metadata stored in the Glue Data Catalog is defined in a
/// DataBrew
/// dataset.
pub const DataCatalogInputDefinition = struct {
    /// The unique identifier of the Amazon Web Services account that holds the Data
    /// Catalog that stores the
    /// data.
    catalog_id: ?[]const u8,

    /// The name of a database in the Data Catalog.
    database_name: []const u8,

    /// The name of a database table in the Data Catalog. This table corresponds to
    /// a DataBrew
    /// dataset.
    table_name: []const u8,

    /// Represents an Amazon location where DataBrew can store intermediate results.
    temp_directory: ?S3Location,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .table_name = "TableName",
        .temp_directory = "TempDirectory",
    };
};
