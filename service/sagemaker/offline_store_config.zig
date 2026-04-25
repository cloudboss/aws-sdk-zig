const DataCatalogConfig = @import("data_catalog_config.zig").DataCatalogConfig;
const S3StorageConfig = @import("s3_storage_config.zig").S3StorageConfig;
const TableFormat = @import("table_format.zig").TableFormat;

/// The configuration of an `OfflineStore`.
///
/// Provide an `OfflineStoreConfig` in a request to `CreateFeatureGroup` to
/// create an `OfflineStore`.
///
/// To encrypt an `OfflineStore` using at rest data encryption, specify Amazon
/// Web Services Key Management Service (KMS) key ID, or `KMSKeyId`, in
/// `S3StorageConfig`.
pub const OfflineStoreConfig = struct {
    /// The meta data of the Glue table for the `OfflineStore`. If not provided,
    /// Feature Store auto-generates the table name, database, and catalog when the
    /// `OfflineStore` is created. You can optionally provide this configuration to
    /// specify custom values. This applies to both Glue and Apache Iceberg table
    /// formats.
    data_catalog_config: ?DataCatalogConfig = null,

    /// Set to `True` to disable the automatic creation of an Amazon Web Services
    /// Glue table when configuring an `OfflineStore`. If set to `True` and
    /// `DataCatalogConfig` is provided, Feature Store associates the provided
    /// catalog configuration with the feature group without creating a table. In
    /// this case, you are responsible for creating and managing the Glue table. If
    /// set to `True` without `DataCatalogConfig`, no Glue table is created or
    /// associated with the feature group. The `Iceberg` table format is only
    /// supported when this is set to `False`.
    ///
    /// If set to `False` and `DataCatalogConfig` is provided, Feature Store creates
    /// the table using the specified names. If set to `False` without
    /// `DataCatalogConfig`, Feature Store auto-generates the table name following
    /// [Athena's naming
    /// recommendations](https://docs.aws.amazon.com/athena/latest/ug/tables-databases-columns-names.html). This applies to both Glue and Apache Iceberg table formats.
    ///
    /// The default value is `False`.
    disable_glue_table_creation: ?bool = null,

    /// The Amazon Simple Storage (Amazon S3) location of `OfflineStore`.
    s3_storage_config: S3StorageConfig,

    /// Format for the offline store table. Supported formats are Glue (Default) and
    /// [Apache Iceberg](https://iceberg.apache.org/).
    table_format: ?TableFormat = null,

    pub const json_field_names = .{
        .data_catalog_config = "DataCatalogConfig",
        .disable_glue_table_creation = "DisableGlueTableCreation",
        .s3_storage_config = "S3StorageConfig",
        .table_format = "TableFormat",
    };
};
