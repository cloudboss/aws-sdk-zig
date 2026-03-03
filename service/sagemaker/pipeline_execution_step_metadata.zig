const AutoMLJobStepMetadata = @import("auto_ml_job_step_metadata.zig").AutoMLJobStepMetadata;
const BedrockCustomModelMetadata = @import("bedrock_custom_model_metadata.zig").BedrockCustomModelMetadata;
const BedrockCustomModelDeploymentMetadata = @import("bedrock_custom_model_deployment_metadata.zig").BedrockCustomModelDeploymentMetadata;
const BedrockModelImportMetadata = @import("bedrock_model_import_metadata.zig").BedrockModelImportMetadata;
const BedrockProvisionedModelThroughputMetadata = @import("bedrock_provisioned_model_throughput_metadata.zig").BedrockProvisionedModelThroughputMetadata;
const CallbackStepMetadata = @import("callback_step_metadata.zig").CallbackStepMetadata;
const ClarifyCheckStepMetadata = @import("clarify_check_step_metadata.zig").ClarifyCheckStepMetadata;
const ConditionStepMetadata = @import("condition_step_metadata.zig").ConditionStepMetadata;
const EMRStepMetadata = @import("emr_step_metadata.zig").EMRStepMetadata;
const EndpointStepMetadata = @import("endpoint_step_metadata.zig").EndpointStepMetadata;
const EndpointConfigStepMetadata = @import("endpoint_config_step_metadata.zig").EndpointConfigStepMetadata;
const FailStepMetadata = @import("fail_step_metadata.zig").FailStepMetadata;
const InferenceComponentMetadata = @import("inference_component_metadata.zig").InferenceComponentMetadata;
const LambdaStepMetadata = @import("lambda_step_metadata.zig").LambdaStepMetadata;
const LineageMetadata = @import("lineage_metadata.zig").LineageMetadata;
const ModelStepMetadata = @import("model_step_metadata.zig").ModelStepMetadata;
const ProcessingJobStepMetadata = @import("processing_job_step_metadata.zig").ProcessingJobStepMetadata;
const QualityCheckStepMetadata = @import("quality_check_step_metadata.zig").QualityCheckStepMetadata;
const RegisterModelStepMetadata = @import("register_model_step_metadata.zig").RegisterModelStepMetadata;
const TrainingJobStepMetadata = @import("training_job_step_metadata.zig").TrainingJobStepMetadata;
const TransformJobStepMetadata = @import("transform_job_step_metadata.zig").TransformJobStepMetadata;
const TuningJobStepMetaData = @import("tuning_job_step_meta_data.zig").TuningJobStepMetaData;

/// Metadata for a step execution.
pub const PipelineExecutionStepMetadata = struct {
    /// The Amazon Resource Name (ARN) of the AutoML job that was run by this step.
    auto_ml_job: ?AutoMLJobStepMetadata = null,

    /// The metadata of the Amazon Bedrock custom model used in the pipeline
    /// execution step.
    bedrock_custom_model: ?BedrockCustomModelMetadata = null,

    /// The metadata of the Amazon Bedrock custom model deployment used in pipeline
    /// execution step.
    bedrock_custom_model_deployment: ?BedrockCustomModelDeploymentMetadata = null,

    /// The metadata of Amazon Bedrock model import used in pipeline execution step.
    bedrock_model_import: ?BedrockModelImportMetadata = null,

    /// The metadata of the Amazon Bedrock provisioned model throughput used in the
    /// pipeline execution step.
    bedrock_provisioned_model_throughput: ?BedrockProvisionedModelThroughputMetadata = null,

    /// The URL of the Amazon SQS queue used by this step execution, the pipeline
    /// generated token, and a list of output parameters.
    callback: ?CallbackStepMetadata = null,

    /// Container for the metadata for a Clarify check step. The configurations and
    /// outcomes of the check step execution. This includes:
    ///
    /// * The type of the check conducted,
    /// * The Amazon S3 URIs of baseline constraints and statistics files to be used
    ///   for the drift check.
    /// * The Amazon S3 URIs of newly calculated baseline constraints and
    ///   statistics.
    /// * The model package group name provided.
    /// * The Amazon S3 URI of the violation report if violations detected.
    /// * The Amazon Resource Name (ARN) of check processing job initiated by the
    ///   step execution.
    /// * The boolean flags indicating if the drift check is skipped.
    /// * If step property `BaselineUsedForDriftCheck` is set the same as
    ///   `CalculatedBaseline`.
    clarify_check: ?ClarifyCheckStepMetadata = null,

    /// The outcome of the condition evaluation that was run by this step execution.
    condition: ?ConditionStepMetadata = null,

    /// The configurations and outcomes of an Amazon EMR step execution.
    emr: ?EMRStepMetadata = null,

    /// The endpoint that was invoked during this step execution.
    endpoint: ?EndpointStepMetadata = null,

    /// The endpoint configuration used to create an endpoint during this step
    /// execution.
    endpoint_config: ?EndpointConfigStepMetadata = null,

    /// The configurations and outcomes of a Fail step execution.
    fail: ?FailStepMetadata = null,

    /// The metadata of the inference component used in pipeline execution step.
    inference_component: ?InferenceComponentMetadata = null,

    /// The Amazon Resource Name (ARN) of the Lambda function that was run by this
    /// step execution and a list of output parameters.
    lambda: ?LambdaStepMetadata = null,

    /// The metadata of the lineage used in pipeline execution step.
    lineage: ?LineageMetadata = null,

    /// The Amazon Resource Name (ARN) of the model that was created by this step
    /// execution.
    model: ?ModelStepMetadata = null,

    /// The Amazon Resource Name (ARN) of the processing job that was run by this
    /// step execution.
    processing_job: ?ProcessingJobStepMetadata = null,

    /// The configurations and outcomes of the check step execution. This includes:
    ///
    /// * The type of the check conducted.
    /// * The Amazon S3 URIs of baseline constraints and statistics files to be used
    ///   for the drift check.
    /// * The Amazon S3 URIs of newly calculated baseline constraints and
    ///   statistics.
    /// * The model package group name provided.
    /// * The Amazon S3 URI of the violation report if violations detected.
    /// * The Amazon Resource Name (ARN) of check processing job initiated by the
    ///   step execution.
    /// * The Boolean flags indicating if the drift check is skipped.
    /// * If step property `BaselineUsedForDriftCheck` is set the same as
    ///   `CalculatedBaseline`.
    quality_check: ?QualityCheckStepMetadata = null,

    /// The Amazon Resource Name (ARN) of the model package that the model was
    /// registered to by this step execution.
    register_model: ?RegisterModelStepMetadata = null,

    /// The Amazon Resource Name (ARN) of the training job that was run by this step
    /// execution.
    training_job: ?TrainingJobStepMetadata = null,

    /// The Amazon Resource Name (ARN) of the transform job that was run by this
    /// step execution.
    transform_job: ?TransformJobStepMetadata = null,

    /// The Amazon Resource Name (ARN) of the tuning job that was run by this step
    /// execution.
    tuning_job: ?TuningJobStepMetaData = null,

    pub const json_field_names = .{
        .auto_ml_job = "AutoMLJob",
        .bedrock_custom_model = "BedrockCustomModel",
        .bedrock_custom_model_deployment = "BedrockCustomModelDeployment",
        .bedrock_model_import = "BedrockModelImport",
        .bedrock_provisioned_model_throughput = "BedrockProvisionedModelThroughput",
        .callback = "Callback",
        .clarify_check = "ClarifyCheck",
        .condition = "Condition",
        .emr = "EMR",
        .endpoint = "Endpoint",
        .endpoint_config = "EndpointConfig",
        .fail = "Fail",
        .inference_component = "InferenceComponent",
        .lambda = "Lambda",
        .lineage = "Lineage",
        .model = "Model",
        .processing_job = "ProcessingJob",
        .quality_check = "QualityCheck",
        .register_model = "RegisterModel",
        .training_job = "TrainingJob",
        .transform_job = "TransformJob",
        .tuning_job = "TuningJob",
    };
};
