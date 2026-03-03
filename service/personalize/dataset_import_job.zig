const DataSource = @import("data_source.zig").DataSource;
const ImportMode = @import("import_mode.zig").ImportMode;

/// Describes a job that imports training data from a data source (Amazon S3
/// bucket) to an Amazon Personalize dataset. For more information, see
/// [CreateDatasetImportJob](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateDatasetImportJob.html).
///
/// A dataset import job can be in one of the following states:
///
/// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
/// FAILED
pub const DatasetImportJob = struct {
    /// The creation date and time (in Unix time) of the dataset import
    /// job.
    creation_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset that receives the
    /// imported data.
    dataset_arn: ?[]const u8 = null,

    /// The ARN of the dataset import job.
    dataset_import_job_arn: ?[]const u8 = null,

    /// The Amazon S3 bucket that contains the training data to import.
    data_source: ?DataSource = null,

    /// If a dataset import job fails, provides the reason why.
    failure_reason: ?[]const u8 = null,

    /// The import mode used by the dataset import job to import new
    /// records.
    import_mode: ?ImportMode = null,

    /// The name of the import job.
    job_name: ?[]const u8 = null,

    /// The date and time (in Unix time) the dataset was last updated.
    last_updated_date_time: ?i64 = null,

    /// Whether the job publishes metrics to Amazon S3 for a metric attribution.
    publish_attribution_metrics_to_s3: ?bool = null,

    /// The ARN of the IAM role that has permissions to read from the Amazon S3
    /// data source.
    role_arn: ?[]const u8 = null,

    /// The status of the dataset import job.
    ///
    /// A dataset import job can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE
    /// FAILED
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_arn = "datasetArn",
        .dataset_import_job_arn = "datasetImportJobArn",
        .data_source = "dataSource",
        .failure_reason = "failureReason",
        .import_mode = "importMode",
        .job_name = "jobName",
        .last_updated_date_time = "lastUpdatedDateTime",
        .publish_attribution_metrics_to_s3 = "publishAttributionMetricsToS3",
        .role_arn = "roleArn",
        .status = "status",
    };
};
