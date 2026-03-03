/// Provides a summary of the properties of a dataset export job. For a complete
/// listing, call the
/// [DescribeDatasetExportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDatasetExportJob.html) API.
pub const DatasetExportJobSummary = struct {
    /// The date and time (in Unix time) that the dataset export job was created.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset export job.
    dataset_export_job_arn: ?[]const u8 = null,

    /// If a dataset export job fails, the reason behind the failure.
    failure_reason: ?[]const u8 = null,

    /// The name of the dataset export job.
    job_name: ?[]const u8 = null,

    /// The date and time (in Unix time) that the dataset export job status was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The status of the dataset export job.
    ///
    /// A dataset export job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_export_job_arn = "datasetExportJobArn",
        .failure_reason = "failureReason",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .status = "status",
    };
};
