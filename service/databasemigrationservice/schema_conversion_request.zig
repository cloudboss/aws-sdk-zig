const ErrorDetails = @import("error_details.zig").ErrorDetails;
const ExportSqlDetails = @import("export_sql_details.zig").ExportSqlDetails;
const Progress = @import("progress.zig").Progress;

/// Provides information about a schema conversion action.
pub const SchemaConversionRequest = struct {
    @"error": ?ErrorDetails = null,

    /// The Amazon S3 location of the ZIP archive that contains the exported data
    /// definition language (DDL) scripts.
    ///
    /// DMS populates this field only for the `DescribeMetadataModelExportsAsScript`
    /// operation.
    export_sql_details: ?ExportSqlDetails = null,

    /// The migration project ARN.
    migration_project_arn: ?[]const u8 = null,

    progress: ?Progress = null,

    /// The identifier for the schema conversion action.
    request_identifier: ?[]const u8 = null,

    /// The schema conversion operation status. Possible values:
    ///
    /// * `RECEIVED` – The operation is received but not yet queued for processing.
    ///
    /// * `IN_PROGRESS` – The operation is queued or actively running.
    ///
    /// * `SUCCESS` – The operation completed successfully.
    ///
    /// * `FAILED` – The operation did not complete.
    ///
    /// * `CANCELING` – The operation is being canceled. The operation might still
    ///   succeed or fail before cancellation takes effect.
    ///
    /// * `CANCELED` – The operation was canceled before completion.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .export_sql_details = "ExportSqlDetails",
        .migration_project_arn = "MigrationProjectArn",
        .progress = "Progress",
        .request_identifier = "RequestIdentifier",
        .status = "Status",
    };
};
