const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointPerformance = @import("endpoint_performance.zig").EndpointPerformance;
const InferenceRecommendation = @import("inference_recommendation.zig").InferenceRecommendation;
const RecommendationJobInputConfig = @import("recommendation_job_input_config.zig").RecommendationJobInputConfig;
const RecommendationJobType = @import("recommendation_job_type.zig").RecommendationJobType;
const RecommendationJobStatus = @import("recommendation_job_status.zig").RecommendationJobStatus;
const RecommendationJobStoppingConditions = @import("recommendation_job_stopping_conditions.zig").RecommendationJobStoppingConditions;

pub const DescribeInferenceRecommendationsJobInput = struct {
    /// The name of the job. The name must be unique within an Amazon Web Services
    /// Region in the Amazon Web Services account.
    job_name: []const u8,

    pub const json_field_names = .{
        .job_name = "JobName",
    };
};

pub const DescribeInferenceRecommendationsJobOutput = struct {
    /// A timestamp that shows when the job completed.
    completion_time: ?i64 = null,

    /// A timestamp that shows when the job was created.
    creation_time: i64,

    /// The performance results from running an Inference Recommender job on an
    /// existing endpoint.
    endpoint_performances: ?[]const EndpointPerformance = null,

    /// If the job fails, provides information why the job failed.
    failure_reason: ?[]const u8 = null,

    /// The recommendations made by Inference Recommender.
    inference_recommendations: ?[]const InferenceRecommendation = null,

    /// Returns information about the versioned model package Amazon Resource Name
    /// (ARN), the traffic pattern, and endpoint configurations you provided when
    /// you initiated the job.
    input_config: ?RecommendationJobInputConfig = null,

    /// The Amazon Resource Name (ARN) of the job.
    job_arn: []const u8,

    /// The job description that you provided when you initiated the job.
    job_description: ?[]const u8 = null,

    /// The name of the job. The name must be unique within an Amazon Web Services
    /// Region in the Amazon Web Services account.
    job_name: []const u8,

    /// The job type that you provided when you initiated the job.
    job_type: RecommendationJobType,

    /// A timestamp that shows when the job was last modified.
    last_modified_time: i64,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role you provided when you initiated the job.
    role_arn: []const u8,

    /// The status of the job.
    status: RecommendationJobStatus,

    /// The stopping conditions that you provided when you initiated the job.
    stopping_conditions: ?RecommendationJobStoppingConditions = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .endpoint_performances = "EndpointPerformances",
        .failure_reason = "FailureReason",
        .inference_recommendations = "InferenceRecommendations",
        .input_config = "InputConfig",
        .job_arn = "JobArn",
        .job_description = "JobDescription",
        .job_name = "JobName",
        .job_type = "JobType",
        .last_modified_time = "LastModifiedTime",
        .role_arn = "RoleArn",
        .status = "Status",
        .stopping_conditions = "StoppingConditions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInferenceRecommendationsJobInput, options: CallOptions) !DescribeInferenceRecommendationsJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInferenceRecommendationsJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeInferenceRecommendationsJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInferenceRecommendationsJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeInferenceRecommendationsJobOutput, body, allocator);
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
