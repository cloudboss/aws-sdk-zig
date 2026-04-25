const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AIRecommendationComputeSpec = @import("ai_recommendation_compute_spec.zig").AIRecommendationComputeSpec;
const AIRecommendationInferenceSpecification = @import("ai_recommendation_inference_specification.zig").AIRecommendationInferenceSpecification;
const AIModelSource = @import("ai_model_source.zig").AIModelSource;
const AIRecommendationOutputConfig = @import("ai_recommendation_output_config.zig").AIRecommendationOutputConfig;
const AIRecommendationPerformanceTarget = @import("ai_recommendation_performance_target.zig").AIRecommendationPerformanceTarget;
const Tag = @import("tag.zig").Tag;

pub const CreateAIRecommendationJobInput = struct {
    /// The name of the AI recommendation job. The name must be unique within your
    /// Amazon Web Services account in the current Amazon Web Services Region.
    ai_recommendation_job_name: []const u8,

    /// The name or Amazon Resource Name (ARN) of the AI workload configuration to
    /// use for this recommendation job.
    ai_workload_config_identifier: []const u8,

    /// The compute resource specification for the recommendation job. You can
    /// specify up to 3 instance types to consider, and optionally provide capacity
    /// reservation configuration.
    compute_spec: ?AIRecommendationComputeSpec = null,

    /// The inference framework configuration. Specify the framework (such as LMI or
    /// vLLM) for the recommendation job.
    inference_specification: ?AIRecommendationInferenceSpecification = null,

    /// The source of the model to optimize. Specify the Amazon S3 location of the
    /// model artifacts.
    model_source: AIModelSource,

    /// Whether to allow model optimization techniques such as quantization,
    /// speculative decoding, and kernel tuning. The default is `true`.
    optimize_model: ?bool = null,

    /// The output configuration for the recommendation job, including the Amazon S3
    /// location for results and an optional model package group where the optimized
    /// model is registered.
    output_config: AIRecommendationOutputConfig,

    /// The performance targets for the recommendation job. Specify constraints on
    /// metrics such as time to first token (`ttft-ms`), `throughput`, or `cost`.
    performance_target: AIRecommendationPerformanceTarget,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// AI to perform tasks on your behalf.
    role_arn: []const u8,

    /// The metadata that you apply to Amazon Web Services resources to help you
    /// categorize and organize them.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .ai_recommendation_job_name = "AIRecommendationJobName",
        .ai_workload_config_identifier = "AIWorkloadConfigIdentifier",
        .compute_spec = "ComputeSpec",
        .inference_specification = "InferenceSpecification",
        .model_source = "ModelSource",
        .optimize_model = "OptimizeModel",
        .output_config = "OutputConfig",
        .performance_target = "PerformanceTarget",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateAIRecommendationJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the created recommendation job.
    ai_recommendation_job_arn: []const u8,

    pub const json_field_names = .{
        .ai_recommendation_job_arn = "AIRecommendationJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAIRecommendationJobInput, options: CallOptions) !CreateAIRecommendationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAIRecommendationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAIRecommendationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAIRecommendationJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAIRecommendationJobOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
