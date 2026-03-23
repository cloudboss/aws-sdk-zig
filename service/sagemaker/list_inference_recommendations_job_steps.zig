const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;
const RecommendationStepType = @import("recommendation_step_type.zig").RecommendationStepType;
const InferenceRecommendationsJobStep = @import("inference_recommendations_job_step.zig").InferenceRecommendationsJobStep;

pub const ListInferenceRecommendationsJobStepsInput = struct {
    /// The name for the Inference Recommender job.
    job_name: []const u8,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A token that you can specify to return more results from the list. Specify
    /// this field if you have a token that was returned from a previous request.
    next_token: ?[]const u8 = null,

    /// A filter to return benchmarks of a specified status. If this field is left
    /// empty, then all benchmarks are returned.
    status: ?RecommendationJobStatus = null,

    /// A filter to return details about the specified type of subtask.
    ///
    /// `BENCHMARK`: Evaluate the performance of your model on different instance
    /// types.
    step_type: ?RecommendationStepType = null,

    pub const json_field_names = .{
        .job_name = "JobName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .status = "Status",
        .step_type = "StepType",
    };
};

pub const ListInferenceRecommendationsJobStepsOutput = struct {
    /// A token that you can specify in your next request to return more results
    /// from the list.
    next_token: ?[]const u8 = null,

    /// A list of all subtask details in Inference Recommender.
    steps: ?[]const InferenceRecommendationsJobStep = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .steps = "Steps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobStepsInput, options: CallOptions) !ListInferenceRecommendationsJobStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInferenceRecommendationsJobStepsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListInferenceRecommendationsJobSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInferenceRecommendationsJobStepsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInferenceRecommendationsJobStepsOutput, body, allocator);
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
