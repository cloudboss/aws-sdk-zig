/// Configuration of the AWS Glue Data Catalog and S3 Tables warehouse used by
/// the Apache Iceberg destination.
pub const Catalog = struct {
    /// The Amazon Resource Name (ARN) of the federated AWS Glue Data Catalog that
    /// projects the S3 Tables bucket. If omitted, MSK derives the catalog ARN from
    /// warehouseLocation.
    catalog_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the S3 Tables bucket that backs the Apache
    /// Iceberg warehouse.
    warehouse_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_arn = "CatalogArn",
        .warehouse_location = "WarehouseLocation",
    };
};
