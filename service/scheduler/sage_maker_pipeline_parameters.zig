const SageMakerPipelineParameter = @import("sage_maker_pipeline_parameter.zig").SageMakerPipelineParameter;

/// The templated target type for the Amazon SageMaker [
/// `StartPipelineExecution`
/// ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_StartPipelineExecution.html) API operation.
pub const SageMakerPipelineParameters = struct {
    /// List of parameter names and values to use when executing the SageMaker Model
    /// Building Pipeline.
    pipeline_parameter_list: ?[]const SageMakerPipelineParameter,

    pub const json_field_names = .{
        .pipeline_parameter_list = "PipelineParameterList",
    };
};
