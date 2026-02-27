const CacheHitResult = @import("cache_hit_result.zig").CacheHitResult;
const PipelineExecutionStepMetadata = @import("pipeline_execution_step_metadata.zig").PipelineExecutionStepMetadata;
const SelectiveExecutionResult = @import("selective_execution_result.zig").SelectiveExecutionResult;
const StepStatus = @import("step_status.zig").StepStatus;

/// An execution of a step in a pipeline.
pub const PipelineExecutionStep = struct {
    /// The current attempt of the execution step. For more information, see [Retry
    /// Policy for SageMaker Pipelines
    /// steps](https://docs.aws.amazon.com/sagemaker/latest/dg/pipelines-retry-policy.html).
    attempt_count: ?i32,

    /// If this pipeline execution step was cached, details on the cache hit.
    cache_hit_result: ?CacheHitResult,

    /// The time that the step stopped executing.
    end_time: ?i64,

    /// The reason why the step failed execution. This is only returned if the step
    /// failed its execution.
    failure_reason: ?[]const u8,

    /// Metadata to run the pipeline step.
    metadata: ?PipelineExecutionStepMetadata,

    /// The ARN from an execution of the current pipeline from which results are
    /// reused for this step.
    selective_execution_result: ?SelectiveExecutionResult,

    /// The time that the step started executing.
    start_time: ?i64,

    /// The description of the step.
    step_description: ?[]const u8,

    /// The display name of the step.
    step_display_name: ?[]const u8,

    /// The name of the step that is executed.
    step_name: ?[]const u8,

    /// The status of the step execution.
    step_status: ?StepStatus,

    pub const json_field_names = .{
        .attempt_count = "AttemptCount",
        .cache_hit_result = "CacheHitResult",
        .end_time = "EndTime",
        .failure_reason = "FailureReason",
        .metadata = "Metadata",
        .selective_execution_result = "SelectiveExecutionResult",
        .start_time = "StartTime",
        .step_description = "StepDescription",
        .step_display_name = "StepDisplayName",
        .step_name = "StepName",
        .step_status = "StepStatus",
    };
};
