/// Provides a summary of the properties of a data deletion job. For a complete
/// listing, call the
/// [DescribeDataDeletionJob](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeDataDeletionJob.html)
/// API operation.
pub const DataDeletionJobSummary = struct {
    /// The creation date and time (in Unix time) of the data deletion
    /// job.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the data deletion job.
    data_deletion_job_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the dataset group the job deleted records
    /// from.
    dataset_group_arn: ?[]const u8 = null,

    /// If a data deletion job fails, provides the reason why.
    failure_reason: ?[]const u8 = null,

    /// The name of the data deletion job.
    job_name: ?[]const u8 = null,

    /// The date and time (in Unix time) the data deletion job was last updated.
    last_updated_date_time: ?i64 = null,

    /// The status of the data deletion job.
    ///
    /// A data deletion job can have one of the following statuses:
    ///
    /// * PENDING > IN_PROGRESS > COMPLETED -or- FAILED
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .data_deletion_job_arn = "dataDeletionJobArn",
        .dataset_group_arn = "datasetGroupArn",
        .failure_reason = "failureReason",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .status = "status",
    };
};
