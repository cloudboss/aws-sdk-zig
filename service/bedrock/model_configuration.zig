const aws = @import("aws");

const InferenceConfiguration = @import("inference_configuration.zig").InferenceConfiguration;

/// Contains the configuration for a model used in an advanced prompt
/// optimization job, including the model ID and inference parameters.
pub const ModelConfiguration = struct {
    /// Additional model request fields. Use this to pass model-specific parameters
    /// that are not included in the standard inference configuration.
    additional_model_request_fields: ?[]const aws.map.StringMapEntry = null,

    /// The inference configuration for the model, including parameters such as
    /// maximum tokens, temperature, and top-p.
    inference_config: ?InferenceConfiguration = null,

    /// The model to use for optimization. The value depends on the resource that
    /// you use:
    ///
    /// * If you use a base model, specify the model ID or its ARN. For a list of
    ///   model IDs, see [Models at a
    ///   glance](https://docs.aws.amazon.com/bedrock/latest/userguide/model-cards.html) in the Amazon Bedrock User Guide.
    /// * If you use a cross-Region (system-defined) inference profile, specify the
    ///   inference profile ID or its ARN. For a list of inference profile IDs, see
    ///   [Supported Regions and models for inference
    ///   profiles](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference-support.html) in the Amazon Bedrock User Guide.
    /// * If you use an application inference profile, specify its full ARN,
    ///   including the account ID and Region.
    model_id: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .inference_config = "inferenceConfig",
        .model_id = "modelId",
    };
};
