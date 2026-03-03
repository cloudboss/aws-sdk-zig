/// The output properties of the data lake access configuration for your catalog
/// resource in the Glue Data Catalog.
pub const DataLakeAccessPropertiesOutput = struct {
    /// Specifies a federated catalog type for the native catalog resource. The
    /// currently supported type is `aws:redshift`.
    catalog_type: ?[]const u8 = null,

    /// Turns on or off data lake access for Apache Spark applications that access
    /// Amazon Redshift databases in the Data Catalog.
    data_lake_access: bool = false,

    /// A role that will be assumed by Glue for transferring data into/out of the
    /// staging bucket during a query.
    data_transfer_role: ?[]const u8 = null,

    /// An encryption key that will be used for the staging bucket that will be
    /// created along with the catalog.
    kms_key: ?[]const u8 = null,

    /// The managed Redshift Serverless compute name that is created for your
    /// catalog resource.
    managed_workgroup_name: ?[]const u8 = null,

    /// The managed Redshift Serverless compute status.
    managed_workgroup_status: ?[]const u8 = null,

    /// The default Redshift database resource name in the managed compute.
    redshift_database_name: ?[]const u8 = null,

    /// A message that gives more detailed information about the managed workgroup
    /// status.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_type = "CatalogType",
        .data_lake_access = "DataLakeAccess",
        .data_transfer_role = "DataTransferRole",
        .kms_key = "KmsKey",
        .managed_workgroup_name = "ManagedWorkgroupName",
        .managed_workgroup_status = "ManagedWorkgroupStatus",
        .redshift_database_name = "RedshiftDatabaseName",
        .status_message = "StatusMessage",
    };
};
