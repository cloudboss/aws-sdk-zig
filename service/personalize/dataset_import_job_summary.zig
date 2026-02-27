const ImportMode = @import("import_mode.zig").ImportMode;

/// Provides a summary of the properties of a dataset import job. For a complete
/// listing, call the
/// [DescribeDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetImportJob.html) API.
pub const DatasetImportJobSummary = struct {
    /// The date and time (in Unix time) that the dataset import job was created.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset import job.
    dataset_import_job_arn: ?[]const u8,

    /// If a dataset import job fails, the reason behind the failure.
    failure_reason: ?[]const u8,

    /// The import mode the dataset import job used to update the data in the
    /// dataset.
    /// For more information see [Updating existing bulk
    /// data](https://docs.aws.amazon.com/personalize/latest/dg/updating-existing-bulk-data.html).
    import_mode: ?ImportMode,

    /// The name of the dataset import job.
    job_name: ?[]const u8,

    /// The date and time (in Unix time) that the dataset import job status was last
    /// updated.
    last_updated_date_time: ?i64,

    /// The status of the dataset import job.
    ///
    /// A dataset import job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_import_job_arn = "datasetImportJobArn",
        .failure_reason = "failureReason",
        .import_mode = "importMode",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .status = "status",
    };
};
