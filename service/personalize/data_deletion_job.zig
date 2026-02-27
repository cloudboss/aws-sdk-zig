const DataSource = @import("data_source.zig").DataSource;

/// Describes a job that deletes all
/// references to specific users from an Amazon Personalize dataset group in
/// batches. For information about creating a data deletion job,
/// see [Deleting
/// users](https://docs.aws.amazon.com/personalize/latest/dg/delete-records.html).
pub const DataDeletionJob = struct {
    /// The creation date and time (in Unix time) of the data deletion
    /// job.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the data deletion job.
    data_deletion_job_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the dataset group the job deletes records
    /// from.
    dataset_group_arn: ?[]const u8,

    data_source: ?DataSource,

    /// If a data deletion job fails, provides the reason why.
    failure_reason: ?[]const u8,

    /// The name of the data deletion job.
    job_name: ?[]const u8,

    /// The date and time (in Unix time) the data deletion job was last updated.
    last_updated_date_time: ?i64,

    /// The number of records deleted by a COMPLETED job.
    num_deleted: ?i32,

    /// The Amazon Resource Name (ARN) of the IAM role that has permissions to read
    /// from the Amazon S3
    /// data source.
    role_arn: ?[]const u8,

    /// The status of the data deletion job.
    ///
    /// A data deletion job can have one of the following statuses:
    ///
    /// * PENDING > IN_PROGRESS > COMPLETED -or- FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .data_deletion_job_arn = "dataDeletionJobArn",
        .dataset_group_arn = "datasetGroupArn",
        .data_source = "dataSource",
        .failure_reason = "failureReason",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .num_deleted = "numDeleted",
        .role_arn = "roleArn",
        .status = "status",
    };
};
