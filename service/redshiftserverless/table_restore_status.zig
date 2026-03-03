/// Contains information about a table restore request.
pub const TableRestoreStatus = struct {
    /// A message that explains the returned status. For example, if the status of
    /// the operation is `FAILED`, the message explains why the operation failed.
    message: ?[]const u8 = null,

    /// The namespace of the table being restored from.
    namespace_name: ?[]const u8 = null,

    /// The name of the table to create from the restore operation.
    new_table_name: ?[]const u8 = null,

    /// The amount of data restored to the new table so far, in megabytes (MB).
    progress_in_mega_bytes: ?i64 = null,

    /// The ID of the recovery point being restored from.
    recovery_point_id: ?[]const u8 = null,

    /// The time that the table restore request was made, in Universal Coordinated
    /// Time (UTC).
    request_time: ?i64 = null,

    /// The name of the snapshot being restored from.
    snapshot_name: ?[]const u8 = null,

    /// The name of the source database being restored from.
    source_database_name: ?[]const u8 = null,

    /// The name of the source schema being restored from.
    source_schema_name: ?[]const u8 = null,

    /// The name of the source table being restored from.
    source_table_name: ?[]const u8 = null,

    /// A value that describes the current state of the table restore request.
    /// Possible values are `SUCCEEDED`, `FAILED`, `CANCELED`, `PENDING`, and
    /// `IN_PROGRESS`.
    status: ?[]const u8 = null,

    /// The ID of the RestoreTableFromSnapshot request.
    table_restore_request_id: ?[]const u8 = null,

    /// The name of the database to restore to.
    target_database_name: ?[]const u8 = null,

    /// The name of the schema to restore to.
    target_schema_name: ?[]const u8 = null,

    /// The total amount of data to restore to the new table, in megabytes (MB).
    total_data_in_mega_bytes: ?i64 = null,

    /// The name of the workgroup being restored from.
    workgroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .namespace_name = "namespaceName",
        .new_table_name = "newTableName",
        .progress_in_mega_bytes = "progressInMegaBytes",
        .recovery_point_id = "recoveryPointId",
        .request_time = "requestTime",
        .snapshot_name = "snapshotName",
        .source_database_name = "sourceDatabaseName",
        .source_schema_name = "sourceSchemaName",
        .source_table_name = "sourceTableName",
        .status = "status",
        .table_restore_request_id = "tableRestoreRequestId",
        .target_database_name = "targetDatabaseName",
        .target_schema_name = "targetSchemaName",
        .total_data_in_mega_bytes = "totalDataInMegaBytes",
        .workgroup_name = "workgroupName",
    };
};
