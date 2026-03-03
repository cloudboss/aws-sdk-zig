const SageMakerPipelineParameter = @import("sage_maker_pipeline_parameter.zig").SageMakerPipelineParameter;

/// These are custom parameters to use when the target is a SageMaker AI Model
/// Building Pipeline
/// that starts based on EventBridge events.
pub const SageMakerPipelineParameters = struct {
    /// List of Parameter names and values for SageMaker AI Model Building Pipeline
    /// execution.
    pipeline_parameter_list: ?[]const SageMakerPipelineParameter = null,

    pub const json_field_names = .{
        .pipeline_parameter_list = "PipelineParameterList",
    };
};
