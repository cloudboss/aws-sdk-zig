const UserContext = @import("user_context.zig").UserContext;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;
const PipelineExecutionStatus = @import("pipeline_execution_status.zig").PipelineExecutionStatus;
const PipelineExperimentConfig = @import("pipeline_experiment_config.zig").PipelineExperimentConfig;
const Parameter = @import("parameter.zig").Parameter;
const SelectiveExecutionConfig = @import("selective_execution_config.zig").SelectiveExecutionConfig;

/// An execution of a pipeline.
pub const PipelineExecution = struct {
    created_by: ?UserContext = null,

    /// The creation time of the pipeline execution.
    creation_time: ?i64 = null,

    /// If the execution failed, a message describing why.
    failure_reason: ?[]const u8 = null,

    last_modified_by: ?UserContext = null,

    /// The time that the pipeline execution was last modified.
    last_modified_time: ?i64 = null,

    /// The parallelism configuration applied to the pipeline execution.
    parallelism_configuration: ?ParallelismConfiguration = null,

    /// The Amazon Resource Name (ARN) of the pipeline that was executed.
    pipeline_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline execution.
    pipeline_execution_arn: ?[]const u8 = null,

    /// The description of the pipeline execution.
    pipeline_execution_description: ?[]const u8 = null,

    /// The display name of the pipeline execution.
    pipeline_execution_display_name: ?[]const u8 = null,

    /// The status of the pipeline status.
    pipeline_execution_status: ?PipelineExecutionStatus = null,

    pipeline_experiment_config: ?PipelineExperimentConfig = null,

    /// Contains a list of pipeline parameters. This list can be empty.
    pipeline_parameters: ?[]const Parameter = null,

    /// The display name of the pipeline version that started this execution.
    pipeline_version_display_name: ?[]const u8 = null,

    /// The ID of the pipeline version that started this execution.
    pipeline_version_id: ?i64 = null,

    /// The selective execution configuration applied to the pipeline run.
    selective_execution_config: ?SelectiveExecutionConfig = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_arn = "PipelineArn",
        .pipeline_execution_arn = "PipelineExecutionArn",
        .pipeline_execution_description = "PipelineExecutionDescription",
        .pipeline_execution_display_name = "PipelineExecutionDisplayName",
        .pipeline_execution_status = "PipelineExecutionStatus",
        .pipeline_experiment_config = "PipelineExperimentConfig",
        .pipeline_parameters = "PipelineParameters",
        .pipeline_version_display_name = "PipelineVersionDisplayName",
        .pipeline_version_id = "PipelineVersionId",
        .selective_execution_config = "SelectiveExecutionConfig",
    };
};
