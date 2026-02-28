const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PerformanceConfigLatency = @import("performance_config_latency.zig").PerformanceConfigLatency;
const ServiceTierType = @import("service_tier_type.zig").ServiceTierType;
const Trace = @import("trace.zig").Trace;
const ResponseStream = @import("response_stream.zig").ResponseStream;

pub const InvokeModelWithResponseStreamInput = struct {
    /// The desired MIME type of the inference body in the response. The default
    /// value is `application/json`.
    accept: ?[]const u8 = null,

    /// The prompt and inference parameters in the format specified in the
    /// `contentType` in the header. You must provide the body in JSON format. To
    /// see the format and content of the request and response bodies for different
    /// models, refer to [Inference
    /// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html). For more information, see [Run inference](https://docs.aws.amazon.com/bedrock/latest/userguide/api-methods-run.html) in the Bedrock User Guide.
    body: ?[]const u8 = null,

    /// The MIME type of the input data in the request. You must specify
    /// `application/json`.
    content_type: ?[]const u8 = null,

    /// The unique identifier of the guardrail that you want to use. If you don't
    /// provide a value, no guardrail is applied to the invocation.
    ///
    /// An error is thrown in the following situations.
    ///
    /// * You don't provide a guardrail identifier but you specify the
    ///   `amazon-bedrock-guardrailConfig` field in the request body.
    /// * You enable the guardrail but the `contentType` isn't `application/json`.
    /// * You provide a guardrail identifier, but `guardrailVersion` isn't
    ///   specified.
    guardrail_identifier: ?[]const u8 = null,

    /// The version number for the guardrail. The value can also be `DRAFT`.
    guardrail_version: ?[]const u8 = null,

    /// The unique identifier of the model to invoke to run inference.
    ///
    /// The `modelId` to provide depends on the type of model or throughput that you
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
    /// * If you use a custom model, specify the ARN of the custom model deployment
    ///   (for on-demand inference) or the ARN of your provisioned model (for
    ///   Provisioned Throughput). For more information, see [Use a custom model in
    ///   Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-use.html) in the Amazon Bedrock User Guide.
    /// * If you use an [imported
    ///   model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html), specify the ARN of the imported model. You can get the model ARN from a successful call to [CreateModelImportJob](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateModelImportJob.html) or from the Imported models page in the Amazon Bedrock console.
    model_id: []const u8,

    /// Model performance settings for the request.
    performance_config_latency: ?PerformanceConfigLatency = null,

    /// Specifies the processing tier type used for serving the request.
    service_tier: ?ServiceTierType = null,

    /// Specifies whether to enable or disable the Bedrock trace. If enabled, you
    /// can see the full Bedrock trace.
    trace: ?Trace = null,

    pub const json_field_names = .{
        .accept = "accept",
        .body = "body",
        .content_type = "contentType",
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .model_id = "modelId",
        .performance_config_latency = "performanceConfigLatency",
        .service_tier = "serviceTier",
        .trace = "trace",
    };
};

pub const InvokeModelWithResponseStreamOutput = struct {
    /// Inference response from the model in the format specified by the
    /// `contentType` header. To see the format and content of this field for
    /// different models, refer to [Inference
    /// parameters](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters.html).
    body: ?ResponseStream = null,

    /// The MIME type of the inference result.
    content_type: []const u8,

    /// Model performance settings for the request.
    performance_config_latency: ?PerformanceConfigLatency = null,

    /// Specifies the processing tier type used for serving the request.
    service_tier: ?ServiceTierType = null,

    pub const json_field_names = .{
        .body = "body",
        .content_type = "contentType",
        .performance_config_latency = "performanceConfigLatency",
        .service_tier = "serviceTier",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeModelWithResponseStreamInput, options: Options) !InvokeModelWithResponseStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}
