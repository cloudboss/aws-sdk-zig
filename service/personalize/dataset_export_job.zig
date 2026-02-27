const IngestionMode = @import("ingestion_mode.zig").IngestionMode;
const DatasetExportJobOutput = @import("dataset_export_job_output.zig").DatasetExportJobOutput;

/// Describes a job that exports a dataset to an Amazon S3 bucket. For more
/// information, see
/// [CreateDatasetExportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetExportJob.html).
///
/// A dataset export job can be in one of the following states:
///
/// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
/// FAILED
pub const DatasetExportJob = struct {
    /// The creation date and time (in Unix time) of the dataset export
    /// job.
    creation_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the dataset to export.
    dataset_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the dataset export job.
    dataset_export_job_arn: ?[]const u8,

    /// If a dataset export job fails, provides the reason why.
    failure_reason: ?[]const u8,

    /// The data to export, based on how you imported the data. You can choose
    /// to export `BULK` data that you imported using a dataset import
    /// job, `PUT` data that you imported incrementally (using the
    /// console, PutEvents, PutUsers and PutItems operations), or `ALL`
    /// for both types. The default value is `PUT`.
    ingestion_mode: ?IngestionMode,

    /// The name of the export job.
    job_name: ?[]const u8,

    /// The path to the Amazon S3 bucket where the job's output is stored. For
    /// example:
    ///
    /// `s3://bucket-name/folder-name/`
    job_output: ?DatasetExportJobOutput,

    /// The date and time (in Unix time) the status of the dataset export job
    /// was last updated.
    last_updated_date_time: ?i64,

    /// The Amazon Resource Name (ARN) of the IAM service role that has
    /// permissions to add data to your output Amazon S3 bucket.
    role_arn: ?[]const u8,

    /// The status of the dataset export job.
    ///
    /// A dataset export job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_arn = "datasetArn",
        .dataset_export_job_arn = "datasetExportJobArn",
        .failure_reason = "failureReason",
        .ingestion_mode = "ingestionMode",
        .job_name = "jobName",
        .job_output = "jobOutput",
        .last_updated_date_time = "lastUpdatedDateTime",
        .role_arn = "roleArn",
        .status = "status",
    };
};
