const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
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

pub const ConverseStreamOutput = @import("converse_stream_response.zig").ConverseStreamResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConverseStreamInput, options: CallOptions) !ConverseStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockruntime");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const stream = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .stream = stream };
}

fn serializeRequest(allocator: std.mem.Allocator, input: ConverseStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockruntime", "Bedrock Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/model/");
    try path_buf.appendSlice(allocator, input.model_id);
    try path_buf.appendSlice(allocator, "/converse-stream");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_model_request_fields) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalModelRequestFields\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.additional_model_response_field_paths) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalModelResponseFieldPaths\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.guardrail_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"guardrailConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.inference_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inferenceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.messages) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"messages\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.performance_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"performanceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prompt_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promptVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_tier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceTier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.system) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"system\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tool_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"toolConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelErrorException")) {
        return .{ .arena = arena, .kind = .{ .model_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .model_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelStreamErrorException")) {
        return .{ .arena = arena, .kind = .{ .model_stream_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ModelTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .model_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
