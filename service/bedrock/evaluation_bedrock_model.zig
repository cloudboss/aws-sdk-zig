const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;

/// Contains the ARN of the Amazon Bedrock model or [inference
/// profile](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference.html) specified in your evaluation job. Each Amazon Bedrock model supports different `inferenceParams`. To learn more about supported inference parameters for Amazon Bedrock models, see [Inference parameters for foundation models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
///
/// The `inferenceParams` are specified using JSON. To successfully insert JSON
/// as string make sure that all quotations are properly escaped. For example,
/// `"temperature":"0.25"` key value pair would need to be formatted as
/// `\"temperature\":\"0.25\"` to successfully accepted in the request.
pub const EvaluationBedrockModel = struct {
    /// Each Amazon Bedrock support different inference parameters that change how
    /// the model behaves during inference.
    inference_params: []const u8 = "{}",

    /// The ARN of the Amazon Bedrock model or inference profile specified.
    model_identifier: []const u8,

    /// Specifies performance settings for the model or inference profile.
    performance_config: ?PerformanceConfiguration,

    pub const json_field_names = .{
        .inference_params = "inferenceParams",
        .model_identifier = "modelIdentifier",
        .performance_config = "performanceConfig",
    };
};
