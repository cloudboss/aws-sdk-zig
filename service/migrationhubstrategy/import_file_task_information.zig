const ImportFileTaskStatus = @import("import_file_task_status.zig").ImportFileTaskStatus;

/// Information about the import file tasks you request.
pub const ImportFileTaskInformation = struct {
    /// The time that the import task completes.
    completion_time: ?i64,

    /// The ID of the import file task.
    id: ?[]const u8,

    /// The name of the import task given in `StartImportFileTask`.
    import_name: ?[]const u8,

    /// The S3 bucket where the import file is located.
    input_s3_bucket: ?[]const u8,

    /// The Amazon S3 key name of the import file.
    input_s3_key: ?[]const u8,

    /// The number of records that failed to be imported.
    number_of_records_failed: ?i32,

    /// The number of records successfully imported.
    number_of_records_success: ?i32,

    /// Start time of the import task.
    start_time: ?i64,

    /// Status of import file task.
    status: ?ImportFileTaskStatus,

    /// The S3 bucket name for status report of import task.
    status_report_s3_bucket: ?[]const u8,

    /// The Amazon S3 key name for status report of import task. The report contains
    /// details about
    /// whether each record imported successfully or why it did not.
    status_report_s3_key: ?[]const u8,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .id = "id",
        .import_name = "importName",
        .input_s3_bucket = "inputS3Bucket",
        .input_s3_key = "inputS3Key",
        .number_of_records_failed = "numberOfRecordsFailed",
        .number_of_records_success = "numberOfRecordsSuccess",
        .start_time = "startTime",
        .status = "status",
        .status_report_s3_bucket = "statusReportS3Bucket",
        .status_report_s3_key = "statusReportS3Key",
    };
};
