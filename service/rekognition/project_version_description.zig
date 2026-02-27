const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;
const CustomizationFeature = @import("customization_feature.zig").CustomizationFeature;
const CustomizationFeatureConfig = @import("customization_feature_config.zig").CustomizationFeatureConfig;
const GroundTruthManifest = @import("ground_truth_manifest.zig").GroundTruthManifest;
const OutputConfig = @import("output_config.zig").OutputConfig;
const ProjectVersionStatus = @import("project_version_status.zig").ProjectVersionStatus;
const TestingDataResult = @import("testing_data_result.zig").TestingDataResult;
const TrainingDataResult = @import("training_data_result.zig").TrainingDataResult;

/// A description of a version of a Amazon Rekognition project version.
pub const ProjectVersionDescription = struct {
    /// The base detection model version used to create the project version.
    base_model_version: ?[]const u8,

    /// The duration, in seconds, that you were billed for a successful training of
    /// the model version.
    /// This value is only returned if the model version has been successfully
    /// trained.
    billable_training_time_in_seconds: ?i64,

    /// The Unix datetime for the date and time that training started.
    creation_timestamp: ?i64,

    /// The training results. `EvaluationResult` is only returned if training is
    /// successful.
    evaluation_result: ?EvaluationResult,

    /// The feature that was customized.
    feature: ?CustomizationFeature,

    /// Feature specific configuration that was applied during training.
    feature_config: ?CustomizationFeatureConfig,

    /// The identifer for the AWS Key Management Service key (AWS KMS key) that was
    /// used to encrypt the model during training.
    kms_key_id: ?[]const u8,

    /// The location of the summary manifest. The summary manifest provides
    /// aggregate data validation results for the training
    /// and test datasets.
    manifest_summary: ?GroundTruthManifest,

    /// The maximum number of inference units Amazon Rekognition uses to auto-scale
    /// the model. Applies
    /// only to Custom Labels projects. For more information, see
    /// StartProjectVersion.
    max_inference_units: ?i32,

    /// The minimum number of inference units used by the model. Applies only to
    /// Custom Labels
    /// projects. For more information, see StartProjectVersion.
    min_inference_units: ?i32,

    /// The location where training results are saved.
    output_config: ?OutputConfig,

    /// The Amazon Resource Name (ARN) of the project version.
    project_version_arn: ?[]const u8,

    /// If the model version was copied from a different project,
    /// `SourceProjectVersionArn` contains the ARN of the source model version.
    source_project_version_arn: ?[]const u8,

    /// The current status of the model version.
    status: ?ProjectVersionStatus,

    /// A descriptive message for an error or warning that occurred.
    status_message: ?[]const u8,

    /// Contains information about the testing results.
    testing_data_result: ?TestingDataResult,

    /// Contains information about the training results.
    training_data_result: ?TrainingDataResult,

    /// The Unix date and time that training of the model ended.
    training_end_timestamp: ?i64,

    /// A user-provided description of the project version.
    version_description: ?[]const u8,

    pub const json_field_names = .{
        .base_model_version = "BaseModelVersion",
        .billable_training_time_in_seconds = "BillableTrainingTimeInSeconds",
        .creation_timestamp = "CreationTimestamp",
        .evaluation_result = "EvaluationResult",
        .feature = "Feature",
        .feature_config = "FeatureConfig",
        .kms_key_id = "KmsKeyId",
        .manifest_summary = "ManifestSummary",
        .max_inference_units = "MaxInferenceUnits",
        .min_inference_units = "MinInferenceUnits",
        .output_config = "OutputConfig",
        .project_version_arn = "ProjectVersionArn",
        .source_project_version_arn = "SourceProjectVersionArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .testing_data_result = "TestingDataResult",
        .training_data_result = "TrainingDataResult",
        .training_end_timestamp = "TrainingEndTimestamp",
        .version_description = "VersionDescription",
    };
};
