const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AIBenchmarkTarget = @import("ai_benchmark_target.zig").AIBenchmarkTarget;
const AIBenchmarkNetworkConfig = @import("ai_benchmark_network_config.zig").AIBenchmarkNetworkConfig;
const AIBenchmarkOutputConfig = @import("ai_benchmark_output_config.zig").AIBenchmarkOutputConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateAIBenchmarkJobInput = struct {
    /// The name of the AI benchmark job. The name must be unique within your Amazon
    /// Web Services account in the current Amazon Web Services Region.
    ai_benchmark_job_name: []const u8,

    /// The name or Amazon Resource Name (ARN) of the AI workload configuration to
    /// use for this benchmark job.
    ai_workload_config_identifier: []const u8,

    /// The target endpoint to benchmark. Specify a SageMaker endpoint by providing
    /// its name or Amazon Resource Name (ARN).
    benchmark_target: AIBenchmarkTarget,

    /// The network configuration for the benchmark job, including VPC settings.
    network_config: ?AIBenchmarkNetworkConfig = null,

    /// The output configuration for the benchmark job, including the Amazon S3
    /// location where benchmark results are stored.
    output_config: AIBenchmarkOutputConfig,

    /// The Amazon Resource Name (ARN) of an IAM role that enables Amazon SageMaker
    /// AI to perform tasks on your behalf.
    role_arn: []const u8,

    /// The metadata that you apply to Amazon Web Services resources to help you
    /// categorize and organize them. Each tag consists of a key and a value, both
    /// of which you define.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .ai_benchmark_job_name = "AIBenchmarkJobName",
        .ai_workload_config_identifier = "AIWorkloadConfigIdentifier",
        .benchmark_target = "BenchmarkTarget",
        .network_config = "NetworkConfig",
        .output_config = "OutputConfig",
        .role_arn = "RoleArn",
        .tags = "Tags",
    };
};

pub const CreateAIBenchmarkJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the created benchmark job.
    ai_benchmark_job_arn: []const u8,

    pub const json_field_names = .{
        .ai_benchmark_job_arn = "AIBenchmarkJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAIBenchmarkJobInput, options: CallOptions) !CreateAIBenchmarkJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAIBenchmarkJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAIBenchmarkJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAIBenchmarkJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAIBenchmarkJobOutput, body, allocator);
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
