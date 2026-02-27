/// Provides a collection of table statistics in response to a request by the
/// `DescribeTableStatistics` operation.
pub const TableStatistics = struct {
    /// The number of data definition language (DDL) statements used to build and
    /// modify the
    /// structure of your tables applied on the target.
    applied_ddls: ?i64,

    /// The number of delete actions applied on a target table.
    applied_deletes: ?i64,

    /// The number of insert actions applied on a target table.
    applied_inserts: ?i64,

    /// The number of update actions applied on a target table.
    applied_updates: ?i64,

    /// The data definition language (DDL) used to build and modify the structure of
    /// your
    /// tables.
    ddls: i64 = 0,

    /// The number of delete actions performed on a table.
    deletes: i64 = 0,

    /// The number of rows that failed conditional checks during the full load
    /// operation (valid
    /// only for migrations where DynamoDB is the target).
    full_load_condtnl_chk_failed_rows: i64 = 0,

    /// The time when the full load operation completed.
    full_load_end_time: ?i64,

    /// The number of rows that failed to load during the full load operation (valid
    /// only for
    /// migrations where DynamoDB is the target).
    full_load_error_rows: i64 = 0,

    /// A value that indicates if the table was reloaded (`true`) or loaded as part
    /// of a new full load operation (`false`).
    full_load_reloaded: ?bool,

    /// The number of rows added during the full load operation.
    full_load_rows: i64 = 0,

    /// The time when the full load operation started.
    full_load_start_time: ?i64,

    /// The number of insert actions performed on a table.
    inserts: i64 = 0,

    /// The last time a table was updated.
    last_update_time: ?i64,

    /// Calculates the percentage of failed validations that were successfully
    /// resynced to the system.
    resync_progress: ?f64,

    /// Records the total number of mismatched data rows where the system attempted
    /// to apply
    /// fixes in the target database.
    resync_rows_attempted: ?i64,

    /// Records the total number of mismatched data rows where fix attempts failed
    /// in the target
    /// database.
    resync_rows_failed: ?i64,

    /// Records the total number of mismatched data rows where fixes were
    /// successfully applied in the target database.
    resync_rows_succeeded: ?i64,

    /// Records the current state of table resynchronization in the migration task.
    ///
    /// This parameter can have the following values:
    ///
    /// * Not enabled – Resync is not enabled for the table in the migration task.
    ///
    /// * Pending – The tables are waiting for resync.
    ///
    /// * In progress – Resync in progress for some records in the table.
    ///
    /// * No primary key – The table could not be resynced because it has no primary
    ///   key.
    ///
    /// * Last resync at: `date/time` – Resync session is finished at time. Time
    ///   provided in UTC format.
    resync_state: ?[]const u8,

    /// The schema name.
    schema_name: ?[]const u8,

    /// The name of the table.
    table_name: ?[]const u8,

    /// The state of the tables described.
    ///
    /// Valid states: Table does not exist | Before load | Full load | Table
    /// completed | Table
    /// cancelled | Table error | Table is being reloaded
    table_state: ?[]const u8,

    /// The number of update actions performed on a table.
    updates: i64 = 0,

    /// The number of records that failed validation.
    validation_failed_records: i64 = 0,

    /// The number of records that have yet to be validated.
    validation_pending_records: i64 = 0,

    /// The validation state of the table.
    ///
    /// This parameter can have the following values:
    ///
    /// * Not enabled – Validation isn't enabled for the table in the migration
    /// task.
    ///
    /// * Pending records – Some records in the table are waiting for
    /// validation.
    ///
    /// * Mismatched records – Some records in the table don't match between the
    /// source and target.
    ///
    /// * Suspended records – Some records in the table couldn't be
    /// validated.
    ///
    /// * No primary key –The table couldn't be validated because it has no
    /// primary key.
    ///
    /// * Table error – The table wasn't validated because it's in an error
    /// state and some data wasn't migrated.
    ///
    /// * Validated – All rows in the table are validated. If the table is updated,
    /// the status can change from Validated.
    ///
    /// * Error – The table couldn't be validated because of an unexpected
    /// error.
    ///
    /// * Pending validation – The table is waiting validation.
    ///
    /// * Preparing table – Preparing the table enabled in the migration task for
    /// validation.
    ///
    /// * Pending revalidation – All rows in the table are pending validation after
    /// the table was updated.
    validation_state: ?[]const u8,

    /// Additional details about the state of validation.
    validation_state_details: ?[]const u8,

    /// The number of records that couldn't be validated.
    validation_suspended_records: i64 = 0,

    pub const json_field_names = .{
        .applied_ddls = "AppliedDdls",
        .applied_deletes = "AppliedDeletes",
        .applied_inserts = "AppliedInserts",
        .applied_updates = "AppliedUpdates",
        .ddls = "Ddls",
        .deletes = "Deletes",
        .full_load_condtnl_chk_failed_rows = "FullLoadCondtnlChkFailedRows",
        .full_load_end_time = "FullLoadEndTime",
        .full_load_error_rows = "FullLoadErrorRows",
        .full_load_reloaded = "FullLoadReloaded",
        .full_load_rows = "FullLoadRows",
        .full_load_start_time = "FullLoadStartTime",
        .inserts = "Inserts",
        .last_update_time = "LastUpdateTime",
        .resync_progress = "ResyncProgress",
        .resync_rows_attempted = "ResyncRowsAttempted",
        .resync_rows_failed = "ResyncRowsFailed",
        .resync_rows_succeeded = "ResyncRowsSucceeded",
        .resync_state = "ResyncState",
        .schema_name = "SchemaName",
        .table_name = "TableName",
        .table_state = "TableState",
        .updates = "Updates",
        .validation_failed_records = "ValidationFailedRecords",
        .validation_pending_records = "ValidationPendingRecords",
        .validation_state = "ValidationState",
        .validation_state_details = "ValidationStateDetails",
        .validation_suspended_records = "ValidationSuspendedRecords",
    };
};
