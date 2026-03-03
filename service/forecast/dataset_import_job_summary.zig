const DataSource = @import("data_source.zig").DataSource;
const ImportMode = @import("import_mode.zig").ImportMode;

/// Provides a summary of the dataset import job properties used in the
/// [ListDatasetImportJobs](https://docs.aws.amazon.com/forecast/latest/dg/API_ListDatasetImportJobs.html) operation. To get the complete set of properties, call the
/// [DescribeDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_DescribeDatasetImportJob.html) operation, and provide the
/// `DatasetImportJobArn`.
pub const DatasetImportJobSummary = struct {
    /// When the dataset import job was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset import job.
    dataset_import_job_arn: ?[]const u8 = null,

    /// The name of the dataset import job.
    dataset_import_job_name: ?[]const u8 = null,

    /// The location of the training data to import and an Identity and Access
    /// Management (IAM) role that Amazon Forecast
    /// can assume to access the data. The training data must be stored in an Amazon
    /// S3 bucket.
    ///
    /// If encryption is used, `DataSource` includes an Key Management Service (KMS)
    /// key.
    data_source: ?DataSource = null,

    /// The import mode of the dataset import job, FULL or INCREMENTAL.
    import_mode: ?ImportMode = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the
    /// job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The status of the dataset import job. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_import_job_arn = "DatasetImportJobArn",
        .dataset_import_job_name = "DatasetImportJobName",
        .data_source = "DataSource",
        .import_mode = "ImportMode",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
    };
};
