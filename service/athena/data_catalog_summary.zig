const ConnectionType = @import("connection_type.zig").ConnectionType;
const DataCatalogStatus = @import("data_catalog_status.zig").DataCatalogStatus;
const DataCatalogType = @import("data_catalog_type.zig").DataCatalogType;

/// The summary information for the data catalog, which includes its name and
/// type.
pub const DataCatalogSummary = struct {
    /// The name of the data catalog. The catalog name is unique for the Amazon Web
    /// Services account and can use a maximum of 127 alphanumeric, underscore, at
    /// sign,
    /// or hyphen characters. The remainder of the length constraint of 256 is
    /// reserved for use
    /// by Athena.
    catalog_name: ?[]const u8,

    /// The type of connection for a `FEDERATED` data catalog (for example,
    /// `REDSHIFT`, `MYSQL`, or `SQLSERVER`). For
    /// information about individual connectors, see [Available data source
    /// connectors](https://docs.aws.amazon.com/athena/latest/ug/connectors-available.html).
    connection_type: ?ConnectionType,

    /// Text of the error that occurred during data catalog creation or deletion.
    @"error": ?[]const u8,

    /// The status of the creation or deletion of the data catalog.
    ///
    /// * The `LAMBDA`, `GLUE`, and `HIVE` data catalog
    /// types are created synchronously. Their status is either
    /// `CREATE_COMPLETE` or `CREATE_FAILED`.
    ///
    /// * The `FEDERATED` data catalog type is created asynchronously.
    ///
    /// Data catalog creation status:
    ///
    /// * `CREATE_IN_PROGRESS`: Federated data catalog creation in
    /// progress.
    ///
    /// * `CREATE_COMPLETE`: Data catalog creation complete.
    ///
    /// * `CREATE_FAILED`: Data catalog could not be created.
    ///
    /// * `CREATE_FAILED_CLEANUP_IN_PROGRESS`: Federated data catalog
    /// creation failed and is being removed.
    ///
    /// * `CREATE_FAILED_CLEANUP_COMPLETE`: Federated data catalog creation
    /// failed and was removed.
    ///
    /// * `CREATE_FAILED_CLEANUP_FAILED`: Federated data catalog creation
    /// failed but could not be removed.
    ///
    /// Data catalog deletion status:
    ///
    /// * `DELETE_IN_PROGRESS`: Federated data catalog deletion in
    /// progress.
    ///
    /// * `DELETE_COMPLETE`: Federated data catalog deleted.
    ///
    /// * `DELETE_FAILED`: Federated data catalog could not be
    /// deleted.
    status: ?DataCatalogStatus,

    /// The data catalog type.
    @"type": ?DataCatalogType,

    pub const json_field_names = .{
        .catalog_name = "CatalogName",
        .connection_type = "ConnectionType",
        .@"error" = "Error",
        .status = "Status",
        .@"type" = "Type",
    };
};
