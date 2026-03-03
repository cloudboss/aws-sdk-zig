const ModelCustomization = @import("model_customization.zig").ModelCustomization;
const InferenceType = @import("inference_type.zig").InferenceType;
const ModelModality = @import("model_modality.zig").ModelModality;
const FoundationModelLifecycle = @import("foundation_model_lifecycle.zig").FoundationModelLifecycle;

/// Information about a foundation model.
pub const FoundationModelDetails = struct {
    /// The customization that the model supports.
    customizations_supported: ?[]const ModelCustomization = null,

    /// The inference types that the model supports.
    inference_types_supported: ?[]const InferenceType = null,

    /// The input modalities that the model supports.
    input_modalities: ?[]const ModelModality = null,

    /// The model Amazon Resource Name (ARN).
    model_arn: []const u8,

    /// The model identifier.
    model_id: []const u8,

    /// Contains details about whether a model version is available or deprecated
    model_lifecycle: ?FoundationModelLifecycle = null,

    /// The model name.
    model_name: ?[]const u8 = null,

    /// The output modalities that the model supports.
    output_modalities: ?[]const ModelModality = null,

    /// The model's provider name.
    provider_name: ?[]const u8 = null,

    /// Indicates whether the model supports streaming.
    response_streaming_supported: ?bool = null,

    pub const json_field_names = .{
        .customizations_supported = "customizationsSupported",
        .inference_types_supported = "inferenceTypesSupported",
        .input_modalities = "inputModalities",
        .model_arn = "modelArn",
        .model_id = "modelId",
        .model_lifecycle = "modelLifecycle",
        .model_name = "modelName",
        .output_modalities = "outputModalities",
        .provider_name = "providerName",
        .response_streaming_supported = "responseStreamingSupported",
    };
};
