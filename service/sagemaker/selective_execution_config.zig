const SelectedStep = @import("selected_step.zig").SelectedStep;

/// The selective execution configuration applied to the pipeline run.
pub const SelectiveExecutionConfig = struct {
    /// A list of pipeline steps to run. All step(s) in all path(s) between two
    /// selected steps should be included.
    selected_steps: []const SelectedStep,

    /// The ARN from a reference execution of the current pipeline. Used to copy
    /// input collaterals needed for the selected steps to run. The execution status
    /// of the pipeline can be either `Failed` or `Success`.
    ///
    /// This field is required if the steps you specify for `SelectedSteps` depend
    /// on output collaterals from any non-specified pipeline steps. For more
    /// information, see [Selective Execution for Pipeline
    /// Steps](https://docs.aws.amazon.com/sagemaker/latest/dg/pipelines-selective-ex.html).
    source_pipeline_execution_arn: ?[]const u8,

    pub const json_field_names = .{
        .selected_steps = "SelectedSteps",
        .source_pipeline_execution_arn = "SourcePipelineExecutionArn",
    };
};
