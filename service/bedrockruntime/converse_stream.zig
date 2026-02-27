const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GuardrailStreamConfiguration = @import("guardrail_stream_configuration.zig").GuardrailStreamConfiguration;
const InferenceConfiguration = @import("inference_configuration.zig").InferenceConfiguration;
const Message = @import("message.zig").Message;
const OutputConfig = @import("output_config.zig").OutputConfig;
const PerformanceConfiguration = @import("performance_configuration.zig").PerformanceConfiguration;
const PromptVariableValues = @import("prompt_variable_values.zig").PromptVariableValues;
const ServiceTier = @import("service_tier.zig").ServiceTier;
const SystemContentBlock = @import("system_content_block.zig").SystemContentBlock;
const ToolConfiguration = @import("tool_configuration.zig").ToolConfiguration;

pub const ConverseStreamInput = struct {
    /// Additional inference parameters that the model supports, beyond the base set
    /// of inference parameters that `Converse` and `ConverseStream` support in the
    /// `inferenceConfig` field. For more information, see [Model
    /// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    additional_model_request_fields: ?[]const u8 = null,

    /// Additional model parameters field paths to return in the response.
    /// `Converse` and `ConverseStream` return the requested fields as a JSON
    /// Pointer object in the `additionalModelResponseFields` field. The following
    /// is example JSON for `additionalModelResponseFieldPaths`.
    ///
    /// `[ "/stop_sequence" ]`
    ///
    /// For information about the JSON Pointer syntax, see the [Internet Engineering
    /// Task Force (IETF)](https://datatracker.ietf.org/doc/html/rfc6901)
    /// documentation.
    ///
    /// `Converse` and `ConverseStream` reject an empty JSON Pointer or incorrectly
    /// structured JSON Pointer with a `400` error code. if the JSON Pointer is
    /// valid, but the requested field is not in the model response, it is ignored
    /// by `Converse`.
    additional_model_response_field_paths: ?[]const []const u8 = null,

    /// Configuration information for a guardrail that you want to use in the
    /// request. If you include `guardContent` blocks in the `content` field in the
    /// `messages` field, the guardrail operates only on those messages. If you
    /// include no `guardContent` blocks, the guardrail operates on all messages in
    /// the request body and in any included prompt resource.
    guardrail_config: ?GuardrailStreamConfiguration = null,

    /// Inference parameters to pass to the model. `Converse` and `ConverseStream`
    /// support a base set of inference parameters. If you need to pass additional
    /// parameters that the model supports, use the `additionalModelRequestFields`
    /// request field.
    inference_config: ?InferenceConfiguration = null,

    /// The messages that you want to send to the model.
    messages: ?[]const Message = null,

    /// Specifies the model or throughput with which to run inference, or the prompt
    /// resource to use in inference. The value depends on the resource that you
    /// use:
    ///
    /// * If you use a base model, specify the model ID or its ARN. For a list of
    ///   model IDs for base models, see [Amazon Bedrock base model IDs (on-demand
    ///   throughput)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html#model-ids-arns) in the Amazon Bedrock User Guide.
    /// * If you use an inference profile, specify the inference profile ID or its
    ///   ARN. For a list of inference profile IDs, see [Supported Regions and
    ///   models for cross-region
    ///   inference](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference-support.html) in the Amazon Bedrock User Guide.
    /// * If you use a provisioned model, specify the ARN of the Provisioned
    ///   Throughput. For more information, see [Run inference using a Provisioned
    ///   Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-thru-use.html) in the Amazon Bedrock User Guide.
    /// * If you use a custom model, first purchase Provisioned Throughput for it.
    ///   Then specify the ARN of the resulting provisioned model. For more
    ///   information, see [Use a custom model in Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-use.html) in the Amazon Bedrock User Guide.
    /// * To include a prompt that was defined in [Prompt
    ///   management](https://docs.aws.amazon.com/bedrock/latest/userguide/prompt-management.html), specify the ARN of the prompt version to use.
    ///
    /// The Converse API doesn't support [imported
    /// models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html).
    model_id: []const u8,

    /// Output configuration for a model response.
    output_config: ?OutputConfig = null,

    /// Model performance settings for the request.
    performance_config: ?PerformanceConfiguration = null,

    /// Contains a map of variables in a prompt from Prompt management to objects
    /// containing the values to fill in for them when running model invocation.
    /// This field is ignored if you don't specify a prompt resource in the
    /// `modelId` field.
    prompt_variables: ?[]const aws.map.MapEntry(PromptVariableValues) = null,

    /// Key-value pairs that you can use to filter invocation logs.
    request_metadata: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the processing tier configuration used for serving the request.
    service_tier: ?ServiceTier = null,

    /// A prompt that provides instructions or context to the model about the task
    /// it should perform, or the persona it should adopt during the conversation.
    system: ?[]const SystemContentBlock = null,

    /// Configuration information for the tools that the model can use when
    /// generating a response.
    ///
    /// For information about models that support streaming tool use, see [Supported
    /// models and model
    /// features](https://docs.aws.amazon.com/bedrock/latest/userguide/conversation-inference.html#conversation-inference-supported-models-features).
    tool_config: ?ToolConfiguration = null,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .additional_model_response_field_paths = "additionalModelResponseFieldPaths",
        .guardrail_config = "guardrailConfig",
        .inference_config = "inferenceConfig",
        .messages = "messages",
        .model_id = "modelId",
        .output_config = "outputConfig",
        .performance_config = "performanceConfig",
        .prompt_variables = "promptVariables",
        .request_metadata = "requestMetadata",
        .service_tier = "serviceTier",
        .system = "system",
        .tool_config = "toolConfig",
    };
};

const ConverseStreamOutput = @import("converse_stream_response.zig").ConverseStreamResponse;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConverseStreamInput, options: Options) !ConverseStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
