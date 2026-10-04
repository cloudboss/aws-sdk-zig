/// The configuration for a Glue Data Catalog table used to store data quality
/// results.
pub const CatalogTableConfigOptions = struct {
    /// A unique identifier for the Glue Data Catalog.
    catalog_id: ?[]const u8 = null,

    /// The name of the database in the Glue Data Catalog.
    database_name: ?[]const u8 = null,

    /// The Amazon S3 location for storing the results.
    s3_location: ?[]const u8 = null,

    /// The name of the table in the Glue Data Catalog.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .s3_location = "S3Location",
        .table_name = "TableName",
    };
};
