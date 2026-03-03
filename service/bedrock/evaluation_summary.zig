const ApplicationType = @import("application_type.zig").ApplicationType;
const EvaluationTaskType = @import("evaluation_task_type.zig").EvaluationTaskType;
const EvaluationInferenceConfigSummary = @import("evaluation_inference_config_summary.zig").EvaluationInferenceConfigSummary;
const EvaluationJobType = @import("evaluation_job_type.zig").EvaluationJobType;
const EvaluationJobStatus = @import("evaluation_job_status.zig").EvaluationJobStatus;

/// Summary information of an evaluation job.
pub const EvaluationSummary = struct {
    /// Specifies whether the evaluation job is for evaluating a model or evaluating
    /// a knowledge base (retrieval and response generation).
    application_type: ?ApplicationType = null,

    /// The time the evaluation job was created.
    creation_time: i64,

    /// The Amazon Resource Names (ARNs) of the models used to compute custom
    /// metrics in an Amazon Bedrock evaluation job.
    custom_metrics_evaluator_model_identifiers: ?[]const []const u8 = null,

    /// The type of task for model evaluation.
    evaluation_task_types: []const EvaluationTaskType,

    /// The Amazon Resource Names (ARNs) of the models used to compute the metrics
    /// for a knowledge base evaluation job.
    evaluator_model_identifiers: ?[]const []const u8 = null,

    /// Identifies the models, Knowledge Bases, or other RAG sources evaluated in a
    /// model or Knowledge Base evaluation job.
    inference_config_summary: ?EvaluationInferenceConfigSummary = null,

    /// The Amazon Resource Name (ARN) of the evaluation job.
    job_arn: []const u8,

    /// The name for the evaluation job.
    job_name: []const u8,

    /// Specifies whether the evaluation job is automated or human-based.
    job_type: EvaluationJobType,

    /// The Amazon Resource Names (ARNs) of the model(s) used for the evaluation
    /// job.
    model_identifiers: []const []const u8 = &.{},

    /// The Amazon Resource Names (ARNs) of the knowledge base resources used for a
    /// knowledge base evaluation job.
    rag_identifiers: ?[]const []const u8 = null,

    /// The current status of the evaluation job.
    status: EvaluationJobStatus,

    pub const json_field_names = .{
        .application_type = "applicationType",
        .creation_time = "creationTime",
        .custom_metrics_evaluator_model_identifiers = "customMetricsEvaluatorModelIdentifiers",
        .evaluation_task_types = "evaluationTaskTypes",
        .evaluator_model_identifiers = "evaluatorModelIdentifiers",
        .inference_config_summary = "inferenceConfigSummary",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .job_type = "jobType",
        .model_identifiers = "modelIdentifiers",
        .rag_identifiers = "ragIdentifiers",
        .status = "status",
    };
};
