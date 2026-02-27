const LabelingJobS3DataSource = @import("labeling_job_s3_data_source.zig").LabelingJobS3DataSource;
const LabelingJobSnsDataSource = @import("labeling_job_sns_data_source.zig").LabelingJobSnsDataSource;

/// Provides information about the location of input data.
///
/// You must specify at least one of the following: `S3DataSource` or
/// `SnsDataSource`.
///
/// Use `SnsDataSource` to specify an SNS input topic for a streaming labeling
/// job. If you do not specify and SNS input topic ARN, Ground Truth will create
/// a one-time labeling job.
///
/// Use `S3DataSource` to specify an input manifest file for both streaming and
/// one-time labeling jobs. Adding an `S3DataSource` is optional if you use
/// `SnsDataSource` to create a streaming labeling job.
pub const LabelingJobDataSource = struct {
    /// The Amazon S3 location of the input data objects.
    s3_data_source: ?LabelingJobS3DataSource,

    /// An Amazon SNS data source used for streaming labeling jobs. To learn more,
    /// see [Send Data to a Streaming Labeling
    /// Job](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-streaming-labeling-job.html#sms-streaming-how-it-works-send-data).
    sns_data_source: ?LabelingJobSnsDataSource,

    pub const json_field_names = .{
        .s3_data_source = "S3DataSource",
        .sns_data_source = "SnsDataSource",
    };
};
