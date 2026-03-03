const LabelingJobResourceConfig = @import("labeling_job_resource_config.zig").LabelingJobResourceConfig;

/// Provides configuration information for auto-labeling of your data objects. A
/// `LabelingJobAlgorithmsConfig` object must be supplied in order to use
/// auto-labeling.
pub const LabelingJobAlgorithmsConfig = struct {
    /// At the end of an auto-label job Ground Truth sends the Amazon Resource Name
    /// (ARN) of the final model used for auto-labeling. You can use this model as
    /// the starting point for subsequent similar jobs by providing the ARN of the
    /// model here.
    initial_active_learning_model_arn: ?[]const u8 = null,

    /// Specifies the Amazon Resource Name (ARN) of the algorithm used for
    /// auto-labeling. You must select one of the following ARNs:
    ///
    /// * *Image classification*
    ///
    /// `arn:aws:sagemaker:*region*:027400017018:labeling-job-algorithm-specification/image-classification`
    /// * *Text classification*
    ///
    /// `arn:aws:sagemaker:*region*:027400017018:labeling-job-algorithm-specification/text-classification`
    /// * *Object detection*
    ///
    /// `arn:aws:sagemaker:*region*:027400017018:labeling-job-algorithm-specification/object-detection`
    /// * *Semantic Segmentation*
    ///
    /// `arn:aws:sagemaker:*region*:027400017018:labeling-job-algorithm-specification/semantic-segmentation`
    labeling_job_algorithm_specification_arn: []const u8,

    /// Provides configuration information for a labeling job.
    labeling_job_resource_config: ?LabelingJobResourceConfig = null,

    pub const json_field_names = .{
        .initial_active_learning_model_arn = "InitialActiveLearningModelArn",
        .labeling_job_algorithm_specification_arn = "LabelingJobAlgorithmSpecificationArn",
        .labeling_job_resource_config = "LabelingJobResourceConfig",
    };
};
