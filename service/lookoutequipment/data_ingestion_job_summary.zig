const IngestionInputConfiguration = @import("ingestion_input_configuration.zig").IngestionInputConfiguration;
const IngestionJobStatus = @import("ingestion_job_status.zig").IngestionJobStatus;

/// Provides information about a specified data ingestion job, including dataset
/// information, data ingestion configuration, and status.
pub const DataIngestionJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the dataset used in the data ingestion
    /// job.
    dataset_arn: ?[]const u8,

    /// The name of the dataset used for the data ingestion job.
    dataset_name: ?[]const u8,

    /// Specifies information for the input data for the data inference job,
    /// including data
    /// Amazon S3 location parameters.
    ingestion_input_configuration: ?IngestionInputConfiguration,

    /// Indicates the job ID of the data ingestion job.
    job_id: ?[]const u8,

    /// Indicates the status of the data ingestion job.
    status: ?IngestionJobStatus,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .ingestion_input_configuration = "IngestionInputConfiguration",
        .job_id = "JobId",
        .status = "Status",
    };
};
