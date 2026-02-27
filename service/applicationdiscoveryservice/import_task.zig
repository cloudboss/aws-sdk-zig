const FileClassification = @import("file_classification.zig").FileClassification;
const ImportStatus = @import("import_status.zig").ImportStatus;

/// An array of information related to the import task request that includes
/// status
/// information, times, IDs, the Amazon S3 Object URL for the import file, and
/// more.
pub const ImportTask = struct {
    /// The total number of application records in the import file that failed to be
    /// imported.
    application_import_failure: i32 = 0,

    /// The total number of application records in the import file that were
    /// successfully
    /// imported.
    application_import_success: i32 = 0,

    /// A unique token used to prevent the same import request from occurring more
    /// than once. If
    /// you didn't provide a token, a token was automatically generated when the
    /// import task request
    /// was sent.
    client_request_token: ?[]const u8,

    /// A link to a compressed archive folder (in the ZIP format) that contains an
    /// error log and a
    /// file of failed records. You can use these two files to quickly identify
    /// records that failed,
    /// why they failed, and correct those records. Afterward, you can upload the
    /// corrected file to
    /// your Amazon S3 bucket and create another import task request.
    ///
    /// This field also includes authorization information so you can confirm the
    /// authenticity of
    /// the compressed archive before you download it.
    ///
    /// If some records failed to be imported we recommend that you correct the
    /// records in the
    /// failed entries file and then imports that failed entries file. This prevents
    /// you from having
    /// to correct and update the larger original file and attempt importing it
    /// again.
    errors_and_failed_entries_zip: ?[]const u8,

    /// The type of file detected by the import task.
    file_classification: ?FileClassification,

    /// The time that the import task request finished, presented in the Unix time
    /// stamp
    /// format.
    import_completion_time: ?i64,

    /// The time that the import task request was deleted, presented in the Unix
    /// time stamp
    /// format.
    import_deleted_time: ?i64,

    /// The time that the import task request was made, presented in the Unix time
    /// stamp
    /// format.
    import_request_time: ?i64,

    /// The unique ID for a specific import task. These IDs aren't globally unique,
    /// but they are
    /// unique within an Amazon Web Services account.
    import_task_id: ?[]const u8,

    /// The URL for your import file that you've uploaded to Amazon S3.
    import_url: ?[]const u8,

    /// A descriptive name for an import task. You can use this name to filter
    /// future requests
    /// related to this import task, such as identifying applications and servers
    /// that were included
    /// in this import task. We recommend that you use a meaningful name for each
    /// import task.
    name: ?[]const u8,

    /// The total number of server records in the import file that failed to be
    /// imported.
    server_import_failure: i32 = 0,

    /// The total number of server records in the import file that were successfully
    /// imported.
    server_import_success: i32 = 0,

    /// The status of the import task. An import can have the status of
    /// `IMPORT_COMPLETE` and still have some records fail to import from the
    /// overall
    /// request. More information can be found in the downloadable archive defined
    /// in the
    /// `errorsAndFailedEntriesZip` field, or in the Migration Hub management
    /// console.
    status: ?ImportStatus,

    pub const json_field_names = .{
        .application_import_failure = "applicationImportFailure",
        .application_import_success = "applicationImportSuccess",
        .client_request_token = "clientRequestToken",
        .errors_and_failed_entries_zip = "errorsAndFailedEntriesZip",
        .file_classification = "fileClassification",
        .import_completion_time = "importCompletionTime",
        .import_deleted_time = "importDeletedTime",
        .import_request_time = "importRequestTime",
        .import_task_id = "importTaskId",
        .import_url = "importUrl",
        .name = "name",
        .server_import_failure = "serverImportFailure",
        .server_import_success = "serverImportSuccess",
        .status = "status",
    };
};
