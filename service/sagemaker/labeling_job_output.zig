/// Specifies the location of the output produced by the labeling job.
pub const LabelingJobOutput = struct {
    /// The Amazon Resource Name (ARN) for the most recent SageMaker model trained
    /// as part of automated data labeling.
    final_active_learning_model_arn: ?[]const u8,

    /// The Amazon S3 bucket location of the manifest file for labeled data.
    output_dataset_s3_uri: []const u8,

    pub const json_field_names = .{
        .final_active_learning_model_arn = "FinalActiveLearningModelArn",
        .output_dataset_s3_uri = "OutputDatasetS3Uri",
    };
};
