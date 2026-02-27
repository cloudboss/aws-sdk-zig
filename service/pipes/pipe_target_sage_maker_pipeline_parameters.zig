const SageMakerPipelineParameter = @import("sage_maker_pipeline_parameter.zig").SageMakerPipelineParameter;

/// The parameters for using a SageMaker pipeline as a target.
pub const PipeTargetSageMakerPipelineParameters = struct {
    /// List of Parameter names and values for SageMaker Model Building Pipeline
    /// execution.
    pipeline_parameter_list: ?[]const SageMakerPipelineParameter,

    pub const json_field_names = .{
        .pipeline_parameter_list = "PipelineParameterList",
    };
};
