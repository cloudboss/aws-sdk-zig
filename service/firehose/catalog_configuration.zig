/// Describes the containers where the destination Apache Iceberg Tables are
/// persisted.
pub const CatalogConfiguration = struct {
    /// Specifies the Glue catalog ARN identifier of the destination Apache Iceberg
    /// Tables. You must specify the ARN in the format
    /// `arn:aws:glue:region:account-id:catalog`.
    catalog_arn: ?[]const u8,

    /// The warehouse location for Apache Iceberg tables. You must configure this
    /// when schema
    /// evolution and table creation is enabled.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    warehouse_location: ?[]const u8,

    pub const json_field_names = .{
        .catalog_arn = "CatalogARN",
        .warehouse_location = "WarehouseLocation",
    };
};
