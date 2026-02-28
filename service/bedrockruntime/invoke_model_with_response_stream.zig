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
    /// The MIME type of the inference result.
    content_type: []const u8,

    /// Model performance settings for the request.
    performance_config_latency: ?PerformanceConfigLatency = null,

    /// Specifies the processing tier type used for serving the request.
    service_tier: ?ServiceTierType = null,

    body: aws.event_stream_reader.EventStreamReader = undefined,

    pub fn deinit(self: *InvokeModelWithResponseStreamOutput) void {
        self.body.deinit();
    }

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
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    stream_resp.deinitHeaders();
    errdefer stream_resp.body.deinit();

    const body = try aws.event_stream_reader.EventStreamReader.init(allocator, stream_resp.body);
    return .{ .body = body };
}

fn serializeRequest(alloc: std.mem.Allocator, input: InvokeModelWithResponseStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockruntime", "Bedrock Runtime", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/model/");
    try path_buf.appendSlice(alloc, input.model_id);
    try path_buf.appendSlice(alloc, "/invoke-with-response-stream");
    const path = try path_buf.toOwnedSlice(alloc);

    const body = input.body orelse "";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-Accept", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(alloc, "Content-Type", v);
    }
    if (input.guardrail_identifier) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-GuardrailIdentifier", v);
    }
    if (input.guardrail_version) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-GuardrailVersion", v);
    }
    if (input.performance_config_latency) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-PerformanceConfig-Latency", @tagName(v));
    }
    if (input.service_tier) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-Service-Tier", @tagName(v));
    }
    if (input.trace) |v| {
        try request.headers.put(alloc, "X-Amzn-Bedrock-Trace", @tagName(v));
    }

    return request;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
