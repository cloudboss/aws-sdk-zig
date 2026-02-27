/// Input properties to configure data lake access for your catalog resource in
/// the Glue Data Catalog.
pub const DataLakeAccessProperties = struct {
    /// Specifies a federated catalog type for the native catalog resource. The
    /// currently supported type is `aws:redshift`.
    catalog_type: ?[]const u8,

    /// Turns on or off data lake access for Apache Spark applications that access
    /// Amazon Redshift databases in the Data Catalog from any non-Redshift engine,
    /// such as Amazon Athena, Amazon EMR, or Glue ETL.
    data_lake_access: bool = false,

    /// A role that will be assumed by Glue for transferring data into/out of the
    /// staging bucket during a query.
    data_transfer_role: ?[]const u8,

    /// An encryption key that will be used for the staging bucket that will be
    /// created along with the catalog.
    kms_key: ?[]const u8,

    pub const json_field_names = .{
        .catalog_type = "CatalogType",
        .data_lake_access = "DataLakeAccess",
        .data_transfer_role = "DataTransferRole",
        .kms_key = "KmsKey",
    };
};
