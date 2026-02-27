const DDBELTCatalogAdditionalOptions = @import("ddbelt_catalog_additional_options.zig").DDBELTCatalogAdditionalOptions;

/// Specifies a DynamoDB data source in the Glue Data Catalog.
pub const DynamoDBCatalogSource = struct {
    /// Specifies additional connection options for the DynamoDB data source.
    additional_options: ?DDBELTCatalogAdditionalOptions,

    /// The name of the database to read from.
    database: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// Specifies whether Point-in-Time Recovery (PITR) is enabled for the DynamoDB
    /// table. When set to `true`,
    /// allows reading from a specific point in time. The default value is `false`.
    pitr_enabled: ?bool,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .database = "Database",
        .name = "Name",
        .pitr_enabled = "PitrEnabled",
        .table = "Table",
    };
};
