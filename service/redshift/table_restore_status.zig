const TableRestoreStatusType = @import("table_restore_status_type.zig").TableRestoreStatusType;

/// Describes the status of a RestoreTableFromClusterSnapshot
/// operation.
pub const TableRestoreStatus = struct {
    /// The identifier of the Amazon Redshift cluster that the table is being
    /// restored
    /// to.
    cluster_identifier: ?[]const u8 = null,

    /// A description of the status of the table restore request. Status values
    /// include
    /// `SUCCEEDED`, `FAILED`, `CANCELED`,
    /// `PENDING`, `IN_PROGRESS`.
    message: ?[]const u8 = null,

    /// The name of the table to create as a result of the table restore request.
    new_table_name: ?[]const u8 = null,

    /// The amount of data restored to the new table so far, in megabytes (MB).
    progress_in_mega_bytes: ?i64 = null,

    /// The time that the table restore request was made, in Universal Coordinated
    /// Time
    /// (UTC).
    request_time: ?i64 = null,

    /// The identifier of the snapshot that the table is being restored from.
    snapshot_identifier: ?[]const u8 = null,

    /// The name of the source database that contains the table being restored.
    source_database_name: ?[]const u8 = null,

    /// The name of the source schema that contains the table being restored.
    source_schema_name: ?[]const u8 = null,

    /// The name of the source table being restored.
    source_table_name: ?[]const u8 = null,

    /// A value that describes the current state of the table restore request.
    ///
    /// Valid Values: `SUCCEEDED`, `FAILED`, `CANCELED`,
    /// `PENDING`, `IN_PROGRESS`
    status: ?TableRestoreStatusType = null,

    /// The unique identifier for the table restore request.
    table_restore_request_id: ?[]const u8 = null,

    /// The name of the database to restore the table to.
    target_database_name: ?[]const u8 = null,

    /// The name of the schema to restore the table to.
    target_schema_name: ?[]const u8 = null,

    /// The total amount of data to restore to the new table, in megabytes (MB).
    total_data_in_mega_bytes: ?i64 = null,
};
