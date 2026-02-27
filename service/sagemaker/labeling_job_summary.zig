const LabelingJobInputConfig = @import("labeling_job_input_config.zig").LabelingJobInputConfig;
const LabelCounters = @import("label_counters.zig").LabelCounters;
const LabelingJobOutput = @import("labeling_job_output.zig").LabelingJobOutput;
const LabelingJobStatus = @import("labeling_job_status.zig").LabelingJobStatus;

/// Provides summary information about a labeling job.
pub const LabelingJobSummary = struct {
    /// The Amazon Resource Name (ARN) of the Lambda function used to consolidate
    /// the annotations from individual workers into a label for a data object. For
    /// more information, see [Annotation
    /// Consolidation](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-annotation-consolidation.html).
    annotation_consolidation_lambda_arn: ?[]const u8,

    /// The date and time that the job was created (timestamp).
    creation_time: i64,

    /// If the `LabelingJobStatus` field is `Failed`, this field contains a
    /// description of the error.
    failure_reason: ?[]const u8,

    /// Input configuration for the labeling job.
    input_config: ?LabelingJobInputConfig,

    /// Counts showing the progress of the labeling job.
    label_counters: LabelCounters,

    /// The Amazon Resource Name (ARN) assigned to the labeling job when it was
    /// created.
    labeling_job_arn: []const u8,

    /// The name of the labeling job.
    labeling_job_name: []const u8,

    /// The location of the output produced by the labeling job.
    labeling_job_output: ?LabelingJobOutput,

    /// The current status of the labeling job.
    labeling_job_status: LabelingJobStatus,

    /// The date and time that the job was last modified (timestamp).
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of a Lambda function. The function is run
    /// before each data object is sent to a worker.
    pre_human_task_lambda_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the work team assigned to the job.
    workteam_arn: []const u8,

    pub const json_field_names = .{
        .annotation_consolidation_lambda_arn = "AnnotationConsolidationLambdaArn",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .input_config = "InputConfig",
        .label_counters = "LabelCounters",
        .labeling_job_arn = "LabelingJobArn",
        .labeling_job_name = "LabelingJobName",
        .labeling_job_output = "LabelingJobOutput",
        .labeling_job_status = "LabelingJobStatus",
        .last_modified_time = "LastModifiedTime",
        .pre_human_task_lambda_arn = "PreHumanTaskLambdaArn",
        .workteam_arn = "WorkteamArn",
    };
};
