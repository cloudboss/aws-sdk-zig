const RecommendationJobInferenceBenchmark = @import("recommendation_job_inference_benchmark.zig").RecommendationJobInferenceBenchmark;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;
const RecommendationStepType = @import("recommendation_step_type.zig").RecommendationStepType;

/// A returned array object for the `Steps` response field in the
/// [ListInferenceRecommendationsJobSteps](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ListInferenceRecommendationsJobSteps.html) API command.
pub const InferenceRecommendationsJobStep = struct {
    /// The details for a specific benchmark.
    inference_benchmark: ?RecommendationJobInferenceBenchmark = null,

    /// The name of the Inference Recommender job.
    job_name: []const u8,

    /// The current status of the benchmark.
    status: RecommendationJobStatus,

    /// The type of the subtask.
    ///
    /// `BENCHMARK`: Evaluate the performance of your model on different instance
    /// types.
    step_type: RecommendationStepType,

    pub const json_field_names = .{
        .inference_benchmark = "InferenceBenchmark",
        .job_name = "JobName",
        .status = "Status",
        .step_type = "StepType",
    };
};
